import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/shared_pref_manager.dart';
import '../../../../domain/entities/firebase_chat/message_entity.dart';
import '../../../../domain/usecases/firebase_chat_usecase/get_message_usecase.dart';
import '../../../../domain/usecases/firebase_chat_usecase/send_message_usecase.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final StreamMessagesUseCase streamMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  StreamSubscription<List<MessageEntity>>? _messagesSubscription;

  String? userId;
  String? username;

  ChatCubit({
    required this.streamMessagesUseCase,
    required this.sendMessageUseCase,
  }) : super(ChatInitial());

  void streamMessages(String chatId) async{
    emit(ChatLoading());
    try {
      _messagesSubscription = streamMessagesUseCase(chatId).listen((messages) {
        emit(ChatLoaded(messages: messages));
      });
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> sendMessage(
      String chatId, MessageEntity message, String customerName) async {
    try {
      await sendMessageUseCase(chatId, message, customerName);
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
