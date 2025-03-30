import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/repositories/firebase_chat_repository/chat_summary_repository.dart';
import '../../models/firebase_chat/chat_summary.dart';

class ChatSummaryRepositoryImpl implements ChatSummaryRepository {
  final FirebaseFirestore _firestore;

  ChatSummaryRepositoryImpl(this._firestore);


  @override
  Stream<List<ChatSummary>> fetchChatSummary(String customerId) {
    try {
      return _firestore
          .collection('Customer_SalesRef')
          .where('Customer_id', whereIn: [customerId, "CALL_CENTER"])
          .snapshots()
          .map((querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          return [];
        }

        final data = querySnapshot.docs.first.data();
        
       

        // chatsData.sort((a, b) {
        //   DateTime aDate = _parseDate(a['last_message_received_at']);
        //   DateTime bDate = _parseDate(b['last_message_received_at']);
        //   return bDate.compareTo(aDate);
        // });

        return querySnapshot.docs.map((doc) {
          final data = doc.data();
          return ChatSummary(
            customerId: data['Customer_id'] ?? '',
            customerName: data['Customer_name'] ?? '',
            salesref_id: data['salesref_id'] ?? '',
            salesref_name: data['salesref_name'] ?? '',
          );
        }).toList();
      });
    } catch (e) {
      print("Error streaming chats: $e");
      return Stream.error('Error streaming chats: $e');
    }
  }

  // DateTime _parseDate(dynamic lastMessageReceivedAt) {
  //   if (lastMessageReceivedAt is Timestamp) {
  //     return lastMessageReceivedAt.toDate();
  //   } else if (lastMessageReceivedAt is String) {
  //     return DateTime.parse(lastMessageReceivedAt);
  //   } else {
  //     return DateTime.now();
  //   }
  // }

}