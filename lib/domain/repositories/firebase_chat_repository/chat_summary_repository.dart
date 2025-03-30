import '../../../data/models/firebase_chat/chat_summary.dart';

abstract class ChatSummaryRepository {
  Stream<List<ChatSummary>> fetchChatSummary(String customerId);
}