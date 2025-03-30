import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/constants/style_manager.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../../data/models/firebase_chat/chat_summary.dart';
import '../../../data/repository_impl/firebase_chat_repository_impl/chat_summary_repository_impl.dart';
import '../../../domain/usecases/firebase_chat_usecase/fetch_summary_usecase.dart';
import '../../routes/routes.dart';
import '../../widgets/chat_list_item.dart';
import '../../widgets/custom_appbar.dart';

class ChatOptionsScreen extends StatefulWidget {
  final FetchChatSummaryUseCase fetchChatsUseCase;
  ChatOptionsScreen({Key? key})
      : fetchChatsUseCase = FetchChatSummaryUseCase(
            ChatSummaryRepositoryImpl(FirebaseFirestore.instance)),
        super(key: key);

  @override
  State<ChatOptionsScreen> createState() => _ChatOptionsScreenState();
}

class _ChatOptionsScreenState extends State<ChatOptionsScreen> {
  String? customerId;
  String? customerName;
  late Future<void> _loadUserId;

  @override
  void initState() {
    super.initState();
    _loadUserId = getUserId();
  }

  Future<void> getUserId() async {
    final sharedPrefManager = SharedPrefManager();
    final managerId = await sharedPrefManager.getManagerId();
    final userId = await sharedPrefManager.getUserId();
    final userName = await sharedPrefManager.getUserName();

    if (userId != null) {
      setState(() {
        customerId = userId;
        customerName = userName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppbar(
        title: "Chats",
        showLeadingIcon: false,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundColor,
        ),
        child: FutureBuilder<void>(
          future: _loadUserId,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CupertinoActivityIndicator(
                color: AppColors.dateTimeColor,
              ));
            }
            if (customerId == null) {
              return Center(
                  child: Text(
                'Error fetching user ID.',
                style: getContentTextMedium(),
              ));
            }

            return FutureBuilder<Stream<List<ChatSummary>>>(
              future: widget.fetchChatsUseCase.execute(customerId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CupertinoActivityIndicator(
                    color: AppColors.dateTimeColor,
                  ));
                }

                if (snapshot.hasError) {
                  return Center(
                      child: Text('Error loading chats.',
                          style: getContentTextMedium()));
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                      child: Text('No chats found.',
                          style: getContentTextSmall()));
                }

                final chatStream = snapshot.data!;

                return Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.backgroundColor,
                  ),
                  child: StreamBuilder<List<ChatSummary>>(
                    stream: chatStream,
                    builder: (context, chatSnapshot) {
                      if (chatSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                            child: CupertinoActivityIndicator(
                                color: AppColors.dateTimeColor));
                      }

                      if (chatSnapshot.hasError) {
                        return Center(
                            child: Text('Error fetching chats.',
                                style: getContentTextMedium()));
                      }

                      if (!chatSnapshot.hasData || chatSnapshot.data!.isEmpty) {
                        return Center(
                            child: Text(
                          'No chats found.',
                          style: getContentTextMedium(),
                        ));
                      }

                      final chats = chatSnapshot.data!;

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          final chat = chats[index];

                          return ChatListItem(
                            onTap: () {
                              context.pushNamed(
                                Routes.chat,
                                pathParameters: {
                                  'salesRefId': chat.salesref_id!,
                                  'customerId': customerId ?? '',
                                  'salesRefName': chat.salesref_name ?? '',
                                  'customerName': customerName ?? ''
                                },
                              );
                            },
                            customerName: chat.salesref_name ?? '',
                            image:
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}


