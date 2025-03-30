import '../../entities/firebase_chat/message_entity.dart';
import '../../repositories/firebase_chat_repository/firebase_chat.dart';

class StreamMessagesUseCase {
  final ChatRepository repository;

  StreamMessagesUseCase(this.repository);

  Stream<List<MessageEntity>> call(String chatId) {
    return repository.streamMessages(chatId);
  }
}