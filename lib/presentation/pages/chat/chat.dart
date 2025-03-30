import 'package:bellagio_mobile_user/domain/usecases/file_download_usecase/file_download_usecase.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/constants/style_manager.dart';
import '../../../core/dependency_injection/service_locator.dart';
import '../../../core/storage/data_state.dart';
import '../../../data/sources/hive_storage_service/hive_storage_serive.dart';
import '../../../domain/entities/firebase_chat/message_entity.dart';
import '../../../domain/repositories/file_uploader_repository/file_uploader_repository.dart';
import '../../../domain/usecases/file_uploader_usecase/file_uploader_usecase.dart';
import '../../../domain/usecases/firebase_chat_usecase/get_message_usecase.dart';
import '../../../domain/usecases/firebase_chat_usecase/send_message_usecase.dart';
import '../../widgets/custom_snackbar.dart';
import 'chat_cubit/chat_cubit.dart';
import 'chat_cubit/chat_state.dart';

class ChatPage extends StatefulWidget {
  final String? salesRefId;
  final String? customerId;
  final String? salesRefName;
  final String? customerName;

  ChatPage(
      {Key? key,
      this.salesRefId,
      this.customerId,
      this.salesRefName,
      this.customerName})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? managerName = "";
  String? userId = "";
  String? salesRefId = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatCubit(
            streamMessagesUseCase: context.read<StreamMessagesUseCase>(),
            sendMessageUseCase: context.read<SendMessageUseCase>(),
          )..streamMessages("${widget.salesRefId}_${widget.customerId}"),
        ),
      ],
      child: _ChatView(
          salesRefId: widget.salesRefId ?? '',
          customerId: widget.customerId ?? '',
          salesRefName: widget.salesRefName ?? '',
          customerName: widget.customerName ?? ''),
    );
  }
}

class _ChatView extends StatefulWidget {
  final String salesRefId;
  final String customerId;
  final String salesRefName;
  final String customerName;

  const _ChatView(
      {Key? key,
      required this.salesRefId,
      required this.customerId,
      required this.salesRefName,
      required this.customerName})
      : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  String? fileUrl = "";
  String? username = "";
  String? userId = "";
  String? salesRefId = "";

  @override
  void initState() {
    super.initState();
    username = widget.customerName;
  }

  // Pick images
  Future<void> _pickAndSubmitImage(BuildContext context) async {
    // Show a dialog to let the user choose between camera and gallery
    final pickedImage = await showDialog<XFile?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select an image source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop(await imagePicker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 30,
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop(await imagePicker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 30,
                  ));
                },
              ),
            ],
          ),
        );
      },
    );

    if (pickedImage != null) {
      // Convert XFile to File
      File file = File(pickedImage.path);

      // Create a MultipartFile
      MultipartFile multipartFile = await MultipartFile.fromFile(file.path);

      //--submit new image--
      FormData formData = FormData();
      formData.files.add(MapEntry('file', multipartFile));
      formData.fields.add(MapEntry('userId', userId ?? ''));
      formData.fields.add(MapEntry('customerName', username ?? ''));

      _uploadImage(username ?? "", userId ?? '', file);
    } else {
      // showHoveringSnackbar(context, 'No image selected');
    }
  }

  // Pick files (e.g., PDF or DOCX)
  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        // allowedExtensions: ['pdf','jpg','png','jpeg'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        print('Picked file: ${file.path}');

        // Open the file
        OpenResult openResult = await OpenFile.open(file.path);

        if (openResult.type != ResultType.done) {
          print('Failed to open file: ${openResult.message}');
        }
        // Handle the file as needed

        _uploadImage(widget.customerName, widget.customerId, file);
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  String cleanUrl(String url) {
    return url.replaceAll('"', '');
  }

  Future<void> _uploadImage(String userName, String userId, File file) async {
    final HiveStorageService hiveStorageService =
        getIt.get<HiveStorageService>();

    // setState(() {
    //   isUploading = true;
    // });
    final FileUploaderRepository uploadImageRepository =
        getIt.get<FileUploaderRepository>();

    final FileUploaderUsecase fileUploaderUsecase =
        getIt.get<FileUploaderUsecase>();

    try {
      // showHoveringSnackbar(context, "Uploading");
      final response = await fileUploaderUsecase(userId, userName, file);

      if (response is DataSuccess && response.data != null) {
        setState(() {
          // isUploading = false;
          fileUrl = cleanUrl(response.data ?? '');
          // uploadSuccess = true;
          // singletonUser.imageURL = response.data?.imageUrl;
        });
        // showHoveringSnackbar(context, 'Upload success');
        if (fileUrl != null) {
          await hiveStorageService.saveDownloadPath(fileUrl!, file.path);
        }

        await context.read<ChatCubit>().sendMessage(
              "${widget.salesRefId}_${widget.customerId}",
              MessageEntity(
                id: '',
                salesRefId: widget.salesRefId,
                customerId: widget.customerId,
                sender: widget.customerId,
                // visibleMessage: file.path,
                message: fileUrl ?? file.path,
                last_message_from: widget.customerId,
                // Pass the file path
                timestamp: DateTime.now(),
                messageType: 'file', // Indicate this is a file message
              ),
              userName,
            );
      } else {
        // setState(() {
        //   isUploading = false;
        // });
        showHoveringSnackbar(context, 'File upload failed! Please try again');
      }
    } catch (e) {
      // setState(() {
      //   isUploading = false;
      // });
      showHoveringSnackbar(context, 'File upload failed! Please try again');
    }
  }

  // Format timestamps
  String formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final isToday = now.day == timestamp.day &&
        now.month == timestamp.month &&
        now.year == timestamp.year;

    if (isToday) {
      return DateFormat('hh:mm a').format(timestamp);
    } else {
      return DateFormat('MMM dd, yyyy').format(timestamp);
    }
  }

  // Send message
  void _sendMessage(BuildContext context) {
    if (_controller.text.isNotEmpty) {
      final cubit = context.read<ChatCubit>();
      cubit.sendMessage(
          "${widget.salesRefId}_${widget.customerId}",
          MessageEntity(
              id: '',
              salesRefId: widget.salesRefId,
              customerId: widget.customerId,
              sender: widget.customerId,
              // visibleMessage: _controller.text,
              message: _controller.text,
              timestamp: DateTime.now(),
              messageType: 'text',
              last_message_from: widget.customerId),
          username ?? '');
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppbar(
        title: widget.salesRefName,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundColor,
            ),
            child: Column(
              children: [
                // Chat messages
                Expanded(
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoading) {
                        return Center(
                            child: CupertinoActivityIndicator(
                          color: AppColors.dateTimeColor,
                        ));
                      } else if (state is ChatLoaded) {
                        final messages = state.messages;
                        return ListView.builder(
                          controller: _scrollController,
                          reverse: true,
                          itemCount: messages.length, // Fix for RangeError
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isSender =
                                message.sender == widget.customerId;

                            bool isImage = message.messageType == 'file' &&
                                (message.message.endsWith('.png') ||
                                    message.message.endsWith('.jpg') ||
                                    message.message.endsWith('.jpeg') ||
                                    message.message.endsWith('.gif'));
                            return Column(
                              crossAxisAlignment: isSender
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: isSender
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Padding(
                                      padding: isSender
                                          ? EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              right: 15)
                                          : EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              left: 15),
                                      child: message.messageType == 'text'
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                              decoration: BoxDecoration(
                                                color: isSender
                                                    ? AppColors.secondaryColor
                                                    : AppColors.navbarActive,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                message.message,
                                                style: TextStyle(
                                                  color: isSender
                                                      ? AppColors
                                                          .contentTextColor
                                                      : Colors.black,
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () async {
                                                print("File download init");

                                                final FileDownloadUsecase
                                                    fileDownload = getIt.get<
                                                        FileDownloadUsecase>();
                                                final HiveStorageService
                                                    hiveStorageService =
                                                    getIt.get<
                                                        HiveStorageService>();

                                                String fileName = message
                                                    .message
                                                    .split('/')
                                                    .last;

                                                String? savedFilePath =
                                                    hiveStorageService
                                                        .getDownloadPath(
                                                            message.message);

                                                if (savedFilePath != null &&
                                                    File(savedFilePath)
                                                        .existsSync()) {
                                                  // File exists, open it
                                                  OpenResult openResult =
                                                      await OpenFile.open(
                                                          savedFilePath);
                                                  if (openResult.type !=
                                                      ResultType.done) {
                                                    print(
                                                        'Failed to open file: ${openResult.message}');
                                                  } else {
                                                    print(
                                                        'Opening file: $savedFilePath');
                                                    return;
                                                  }
                                                }

                                                print(
                                                    "File not found, downloading again...");
                                                String downloadPath =
                                                    await getDownloadPath(
                                                        fileName);

                                                final result =
                                                    await fileDownload.call(
                                                        message.message,
                                                        downloadPath);

                                                if (result is DataSuccess) {
                                                  await hiveStorageService
                                                      .saveDownloadPath(
                                                          message.message,
                                                          downloadPath);

                                                  OpenResult openResult =
                                                      await OpenFile.open(
                                                          downloadPath);
                                                  if (openResult.type !=
                                                      ResultType.done) {
                                                    print(
                                                        'Failed to open file: ${openResult.message}');
                                                  }
                                                  print(
                                                      'Opening file: $downloadPath');
                                                } else {
                                                  print(
                                                      "Download failed: ${result.error}");
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                  color: isSender
                                                      ? AppColors.secondaryColor
                                                      : AppColors.navbarActive,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: isImage
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          message
                                                              .message, // The image URL
                                                          fit: BoxFit
                                                              .cover, // Maintain aspect ratio
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Icon(
                                                                  Icons
                                                                      .broken_image,
                                                                  size: 50,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      )
                                                    : Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .insert_drive_file,
                                                              color: AppColors
                                                                  .textColor),
                                                          SizedBox(width: 5),
                                                          Flexible(
                                                            child: Text(
                                                              message.message
                                                                  .split('/')
                                                                  .last, // Show file name
                                                              softWrap: true,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                color: isSender
                                                                    ? AppColors
                                                                        .contentTextColor
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                              ))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10),
                                  child: Text(
                                    formatTimestamp(message.timestamp),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (state is ChatError) {
                        return Center(
                          child: Text(
                            'Error: ${state.message}',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return Center(child: Text('No messages'));
                      }
                    },
                  ),
                ),
                // Bottom input bar
                Container(
                  width: double.infinity,
                  child: BottomAppBar(
                    color: AppColors.navbarColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // IconButton(
                          //   icon: Icon(Icons.attach_file),
                          //   onPressed: _pickFile,
                          // ),
                          GestureDetector(
                            onTap: _pickFile,
                            child: Icon(
                              Icons.attach_file,
                              color: AppColors.textfieldColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () => _pickAndSubmitImage(context),
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.textfieldColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // IconButton(
                          //   icon: Icon(Icons.camera_alt),
                          //   onPressed: _pickImage,
                          //   padding: EdgeInsets.all(0),
                          // ),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              maxLines: 2,
                              minLines: 1,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle: getTextfieldLabel(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.textfieldColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.textfieldColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              style: getTextfieldLabel(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send,
                                color: AppColors.textfieldColor),
                            onPressed: () => _sendMessage(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getDownloadPath(String fileName) async {
    Directory? directory;

    if (Platform.isAndroid) {
      directory = Directory("/storage/emulated/0/Download");
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    }

    return "${directory!.path}/$fileName";
  }
}
