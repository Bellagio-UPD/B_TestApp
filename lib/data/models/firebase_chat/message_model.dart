
import '../../../domain/entities/firebase_chat/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.salesRefId,
    required super.customerId,
    required super.sender,
    required super.message,
    required super.messageType,
    required super.timestamp,
    required super.last_message_from
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      salesRefId: json['salesRefId'],
      customerId: json['customerId'],
      sender: json['sender'],
      message: json['message'],
      messageType: json['messageType'],
      timestamp: DateTime.parse(json['timestamp']),
      last_message_from: json['last_message_from']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'salesRefId': salesRefId,
      'customerId': customerId,
      'message': message,
      'messageType': messageType,
      'timestamp': timestamp.toIso8601String(),
      'last_message_from':last_message_from
    };
  }
}