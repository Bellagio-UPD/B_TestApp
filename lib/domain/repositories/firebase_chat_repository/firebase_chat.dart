import '../../entities/firebase_chat/message_entity.dart';

abstract class ChatRepository {
  Stream<List<MessageEntity>> streamMessages(String chatId);
  Future<void> sendMessage(String chatId, MessageEntity message,String customerName);
}
