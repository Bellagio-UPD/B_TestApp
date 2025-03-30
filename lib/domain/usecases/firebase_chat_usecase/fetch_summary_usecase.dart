import '../../../data/models/firebase_chat/chat_summary.dart';
import '../../repositories/firebase_chat_repository/chat_summary_repository.dart';

class FetchChatSummaryUseCase {
  final ChatSummaryRepository repository;

  FetchChatSummaryUseCase(this.repository);

  Future<Stream<List<ChatSummary>>> execute(String customerId) async {
    return repository.fetchChatSummary(customerId);
  }
}