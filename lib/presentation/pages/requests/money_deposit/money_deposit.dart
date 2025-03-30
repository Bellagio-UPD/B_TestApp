import 'dart:io';

import 'package:bellagio_mobile_user/data/models/packages_model/packages_model.dart';
import 'package:bellagio_mobile_user/data/models/request_model/sub_models/deposit_details_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/file_uploader_repository/file_uploader_repository.dart';
import 'package:bellagio_mobile_user/domain/usecases/file_uploader_usecase/file_uploader_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/packages_usecase/get_packages_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/packages/packages_cubit/packages_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_date_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/request_types.dart';
import '../../../../core/constants/style_manager.dart';
import '../../../../core/dependency_injection/service_locator.dart';
import '../../../../core/storage/data_state.dart';
import '../../../../core/storage/shared_pref_manager.dart';
import '../../../../data/models/request_model/request_model.dart';
import '../../../../domain/usecases/request_usecase/request_usecase.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/custom_time_picker.dart';
import '../../../widgets/primary_button.dart';
import '../requests_cubit/requests_cubit.dart';

class MoneyDeposit extends StatefulWidget {
  final DepositDetails? depositModel;
  MoneyDeposit({super.key, this.depositModel});

  @override
  State<MoneyDeposit> createState() => _MoneyDepositState();
}

class _MoneyDepositState extends State<MoneyDeposit> {
  String _userId = "";
  String _userName = "";
  String selectedDate = '';
  String selectedTime = "";
  String location = "";
  PackagesModel? package;
  String packageName = "";
  List<PackagesModel> packagesList = [];
  final _formKey = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();
  bool isUploading = false;
  bool uploadSuccess = false;
  bool _isLoading = false;
  String? profileImageUrl;
  String cleanUrl = "";
  // String selectedDateTime = '';
  ButtonState _buttonState = ButtonState.normal;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  void _getUserId() async {
    final sharedPrefManager = SharedPrefManager();
    final userId = await sharedPrefManager.getUserId();
    final userName =
        await sharedPrefManager.getUserName(); // Resolve the Future here
    if (userId != null && userName != null) {
      setState(() {
        _userId = userId;
        _userName = userName; // Assign the actual value, not the Future
      });
    } else {}
  }

  String extractPackageName(PackagesModel packagesModel) {
    return packagesModel.Name ?? '';
  }

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
      formData.fields.add(MapEntry('userId', _userId));
      formData.fields.add(MapEntry('customerName', _userName));
      print("-=--=-=--=-${_userName}");

      _uploadImage(_userName, _userId, file);
    } else {
      // showHoveringSnackbar(context, 'No image selected');
    }
  }

  Future<void> _uploadImage(String userName, String userId, File file) async {
    setState(() {
      isUploading = true;
    });
    final FileUploaderRepository uploadImageRepository =
        getIt.get<FileUploaderRepository>();

    final FileUploaderUsecase fileUploaderUsecase =
        getIt.get<FileUploaderUsecase>();

    try {
      showHoveringSnackbar(context, "Uploading");
      final response = await fileUploaderUsecase(userName, userId, file);

      if (response is DataSuccess && response.data != null) {
        setState(() {
          isUploading = false;
          profileImageUrl = response.data;
          uploadSuccess = true;
          // singletonUser.imageURL = response.data?.imageUrl;
        });
        // showHoveringSnackbar(context, 'Upload success');
      } else {
        setState(() {
          isUploading = false;
        });
        showHoveringSnackbar(context, 'Image upload failed! Please try again');
      }
    } catch (e) {
      setState(() {
        isUploading = false;
      });
      showHoveringSnackbar(context, 'Image upload failed! Please try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PackagesCubit(
                getPackagesUsecase: getIt.get<GetPackagesUsecase>())
              ..getPackages(),
          ),
          BlocProvider(
            create: (context) =>
                RequestCubit(requestUsecase: getIt.get<RequestUsecase>()),
          ),
        ],
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            // extendBodyBehindAppBar: true,
            appBar: CustomAppbar(
              title: "Package request",
            ),
            body: Stack(children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    const BoxDecoration(gradient: AppColors.backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          CustomTextfield(
                            hint: "Enter your meeting location",
                            label: "Meeting location",
                            onChanged: (value) {
                              location = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your meeting location.';
                              }
                              return null;
                            },
                          ),
                          DatePicker(
                            title: "Date",
                            hint: "Please select a date",
                            onDateSelected: (date) {
                              setState(() {
                                selectedDate = date; // Capture selected date
                              });
                            },
                            validator: (value) {
                              if (selectedDate.isEmpty) {
                                return 'Please select a date';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              selectedDate = value!;
                            },
                          ),
                          TimePicker(
                            onTimeSelected: (time) {
                              setState(() {
                                selectedTime = time;
                              });
                            },
                            validator: (value) {
                              if (selectedTime.isEmpty) {
                                return 'Please select a time';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              selectedTime = value!;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Upload a file/image",
                                  style: getContentTextLarge()),
                              const SizedBox(height: 10),
                              Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.tileColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                    onTap: () {
                                      _pickAndSubmitImage(context);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: uploadSuccess
                                            ? Column(
                                                children: [
                                                  Icon(
                                                    Icons.check_circle_outline,
                                                    size: 30,
                                                    color: AppColors
                                                        .secondaryColor,
                                                  ),
                                                  Text(
                                                    "File uploaded successfully!",
                                                    style: getTextfieldLabel(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  Icon(
                                                    Icons.upload_file_rounded,
                                                    size: 30,
                                                    color: AppColors
                                                        .secondaryColor,
                                                  ),
                                                  Text(
                                                    "Upload file",
                                                    style: getTextfieldLabel(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                ],
                                              )),
                                  )),
                            ],
                          ),
                          SizedBox(height: 60),
                          PrimaryButton(
                              // buttonState: _buttonState,
                              label: "Send Request",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  if (profileImageUrl != null) {
                                    setState(() {
                                      cleanUrl =
                                          profileImageUrl!.replaceAll('""', "");
                                    });
                                  }
                                  final depositModel = DepositDetails(
                                      Document: cleanUrl,
                                      RequestDate:
                                          "${selectedDate} ${selectedTime}",
                                      Location: location,
                                      PackageName:
                                          widget.depositModel!.PackageName ??
                                              '',
                                      PackageId:
                                          widget.depositModel!.PackageId ?? '');

                                  final model = RequestModel(
                                      IsLongTrip: true,
                                      CustomerName: _userName,
                                      CustomerId: _userId,
                                      Title: moneyPickUpRequest,
                                      Details: depositModel,
                                      RequestType: moneyPickUpRequest);
                                  final request = await context
                                      .read<RequestCubit>()
                                      .createRequest(model);

                                  if (request is DataFailed) {
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    showHoveringSnackbar(
                                        context, "Failed to create request.");
                                  } else {
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    setState(() {
                                      _isLoading = false;
                                      _buttonState = ButtonState.success;
                                    });
                                    GoRouter.of(context)
                                        .goNamed(Routes.navDashboard);
                                  }
                                }
                              },
                              buttonStyleType: ButtonStyleType.filled)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    color: AppColors.purple3.withOpacity(0.85),
                    child: Center(
                        child: LoadingAnimationWidget.hexagonDots(
                            color: AppColors.secondaryColor, size: 70)),
                  ),
                ),
            ]),
          ),
        ));
  }
}
