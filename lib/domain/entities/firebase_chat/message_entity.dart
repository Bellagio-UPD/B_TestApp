class MessageEntity {
  final String id;
  final String salesRefId;
  final String customerId;
  final String sender;
  final String message;
  // final String visibleMessage;
  final String messageType;
  final DateTime timestamp;
  final String? last_message_from;

  const MessageEntity(
      {required this.id,
      required this.salesRefId,
      required this.customerId,
      required this.sender,
      // required this.visibleMessage,
      required this.message,
      required this.messageType,
      required this.timestamp,
      this.last_message_from});
}
