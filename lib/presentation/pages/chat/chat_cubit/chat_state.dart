import '../../../../domain/entities/firebase_chat/message_entity.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoadingMore extends ChatState {
  final List<MessageEntity> currentMessages;
  ChatLoadingMore({required this.currentMessages});
}

class ChatLoaded extends ChatState {
  final List<MessageEntity> messages;
  ChatLoaded({required this.messages});
}

class ChatError extends ChatState {
  final String message;
  ChatError({required this.message});
}
