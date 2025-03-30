import '../../entities/firebase_chat/message_entity.dart';
import '../../repositories/firebase_chat_repository/firebase_chat.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> call(String chatId, MessageEntity message,String customerName) {
    return repository.sendMessage(chatId, message,customerName);
  }
}