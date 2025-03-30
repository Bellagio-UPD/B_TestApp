class ChatSummary {
  final String customerId;
  final String customerName;
  final String? lastMessage;
  final DateTime? lastMessageReceivedAt;
  final int? totalUnreads;
  final String? last_message_from;
  final String? salesref_id;
  final String? salesref_name;

  const ChatSummary(
      {required this.customerId,
      required this.customerName,
      this.lastMessage,
      this.lastMessageReceivedAt,
      this.totalUnreads,
      this.last_message_from,
      this.salesref_id,
      this.salesref_name});
}
