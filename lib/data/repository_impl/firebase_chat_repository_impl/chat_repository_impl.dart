import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/firebase_chat/message_entity.dart';
import '../../../domain/repositories/firebase_chat_repository/firebase_chat.dart';
import '../../models/firebase_chat/chat_summary.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore firestore;

  ChatRepositoryImpl(this.firestore);
  final int pageSize = 20;
  DocumentSnapshot? _lastVisible;

  @override
  Stream<List<MessageEntity>> streamMessages(String chatId, {bool nextPage = false}) {
    Query query = firestore
        .collection('Chats')
        .doc(chatId)
        .collection('MessageBulks')
        .orderBy('bulkId', descending: true)
        .limit(pageSize);

    if (nextPage && _lastVisible != null) {
      query = query.startAfter([_lastVisible!.get('bulkId')]);
    }

    return query.snapshots().map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return [];
      }

      _lastVisible = snapshot.docs.last;

      return snapshot.docs.expand((doc) {
        final bulkData = doc.data() as Map<String, dynamic>?;
        final List<dynamic> messages = bulkData?['messages'] ?? [];
        messages.sort((a, b) {
          DateTime aDate = (a['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now();
          DateTime bDate = (b['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now();
          return bDate.compareTo(aDate); // Sort by descending timestamp
        });

        return messages.map((msg) => MessageEntity(
          id: msg['id'] ?? '',
          salesRefId: msg['salesRefId'] ?? '',
          customerId: msg['customerId'] ?? '',
          sender: msg['sender'] ?? '',
          message: msg['message'] ?? '',
          messageType: msg['messageType'] ?? '',
          timestamp: (msg['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
          last_message_from: (msg['last_message_from'] ?? '')
        ));
      }).toList();
    });
  }

  Future<void> loadMoreMessages() async {
    final messagesStream = streamMessages('chatId', nextPage: true);
  }
  @override
  Future<void> sendMessage(String chatId, MessageEntity message, String customerName) async {
    final metadataRef = firestore.collection('Chats').doc(chatId);
    final bulkCollection = metadataRef.collection('MessageBulks');

    // Get the latest bulk document
    final querySnapshot =
    await bulkCollection.orderBy('bulkId', descending: true).limit(1).get();

    final batch = firestore.batch();
    Map<String, dynamic> bulkData;
    DocumentReference? bulkDocRef;

    if (querySnapshot.docs.isEmpty) {
      // Create the first bulk if no bulks exist
      bulkDocRef = bulkCollection.doc('bulk_1');
      bulkData = {'bulkId': 1, 'messages': []};
    } else {
      // Get the latest bulk document
      final doc = querySnapshot.docs.first;
      bulkDocRef = doc.reference;
      bulkData = doc.data() as Map<String, dynamic>;
    }

    // Add the message to the bulk
    final List<dynamic> messages = bulkData['messages'] ?? [];
    messages.add({
      'id': message.id,
      'salesRefId': message.salesRefId,
      'customerId': message.customerId,
      'sender': message.sender,
      'message': message.message,
      'messageType': message.messageType,
      'timestamp': message.timestamp,
      'last_message_from':message.last_message_from
    });

    if (messages.length > 100) {
      // Create a new bulk if the current one exceeds the limit
      final newBulkId = (bulkData['bulkId'] as int) + 1;
      bulkDocRef = bulkCollection.doc('bulk_$newBulkId');
      bulkData = {'bulkId': newBulkId, 'messages': [messages.last]};
    } else {
      bulkData['messages'] = messages;
    }

    // Update the bulk document
    batch.set(bulkDocRef, bulkData);

    // Update the chat metadata
    batch.set(metadataRef, {
      'lastMessage': message.message,
      'lastMessageType': message.messageType,
      'lastTimestamp': message.timestamp,
    }, SetOptions(merge: true));

    // Commit the batch
    await batch.commit();

    // After the batch commit, update the chat summary
    final chatSummary = ChatSummary(
      customerId: message.customerId,
      customerName: customerName,
      lastMessage: message.message,
      lastMessageReceivedAt: message.timestamp,
      totalUnreads: 0,  // As this is sales ref side always setting this 0
      last_message_from: message.last_message_from ?? ''
    );

    // Call the updateChatSummary function
    await updateChatSummary(message.salesRefId, chatSummary);

  }

  Future<void> updateChatSummary(String salesRefId, ChatSummary chatSummary) async {
    try {
      final querySnapshot = await firestore
          .collection('SalesRef_ChatSummary')
          .where('sales_ref_id', isEqualTo: salesRefId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // If no existing record is found, create a new one
        await firestore.collection('SalesRef_ChatSummary').add({
          'sales_ref_id': salesRefId,
          'chats': [
            {
              'customer_id': chatSummary.customerId,
              'customer_name': chatSummary.customerName,
              'last_message': chatSummary.lastMessage,
              'last_message_received_at': chatSummary.lastMessageReceivedAt?.toIso8601String(),
              'total_unreads': chatSummary.totalUnreads,
              'last_message_from': chatSummary.last_message_from
            }
          ]
        });
      } else {
        // If a record exists, update the chats array
        final doc = querySnapshot.docs.first;
        final docRef = doc.reference;
        final data = doc.data();
        final List<dynamic> chatsData = data['chats'] ?? [];

        // Check if the customer ID already exists in the chats array
        bool customerExists = false;
        for (int i = 0; i < chatsData.length; i++) {
          if (chatsData[i]['customer_id'] == chatSummary.customerId) {
            // Update the existing chat
            chatsData[i] = {
              'customer_id': chatSummary.customerId,
              'customer_name': chatSummary.customerName,
              'last_message': chatSummary.lastMessage,
              'last_message_received_at': chatSummary.lastMessageReceivedAt?.toIso8601String(),
              'total_unreads': chatSummary.totalUnreads,
              'last_message_from': chatSummary.last_message_from
            };
            customerExists = true;
            break;
          }
        }

        if (!customerExists) {
          // If the customer doesn't exist, add a new entry
          chatsData.add({
            'customer_id': chatSummary.customerId,
            'customer_name': chatSummary.customerName,
            'last_message': chatSummary.lastMessage,
            'last_message_received_at': chatSummary.lastMessageReceivedAt?.toIso8601String(),
            'total_unreads': chatSummary.totalUnreads,
            'last_message_from': chatSummary.last_message_from
          });
        }

        // Update the document with the modified chats array
        await docRef.update({'chats': chatsData});
      }
    } catch (e) {
    }
  }

}