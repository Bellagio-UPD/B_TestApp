import 'package:bellagio_mobile_user/core/constants/request_types.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/general_request_model/general_request_model.dart';
import 'package:bellagio_mobile_user/data/models/request_model/request_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/general_request_usecase/general_request_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/general_request/general_request_cubit/general_request_cubit.dart';
import 'package:bellagio_mobile_user/presentation/routes/routes.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_dropdown.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_textfield.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../../domain/usecases/request_usecase/request_usecase.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_snackbar.dart';
import '../requests/requests_cubit/requests_cubit.dart';

class GeneralUserRequest extends StatefulWidget {
  const GeneralUserRequest({super.key});

  @override
  State<GeneralUserRequest> createState() => _GeneralUserRequestState();
}

class _GeneralUserRequestState extends State<GeneralUserRequest> {
  String _userId = "";
  String details = "";
  String title = "";

  late GeneralRequestCubit _generalRequestCubit;
  final List<String> requestList = [
    airTicketRequest,
    hotelReservationRequest,
    transportRequest,
    moneyPickUpRequest,
    "Other booking"
  ];

  @override
  void initState() {
    super.initState();
    _getUserId();
    initialise();
  }

  void _getUserId() async {
    final sharedPrefManager = SharedPrefManager();
    final userId =
        await sharedPrefManager.getUserId(); // Resolve the Future here
    if (userId != null) {
      setState(() {
        _userId = userId; // Assign the actual value, not the Future
      });
  
    } else {

    }
  }

  Future<void> initialise() async {
    _generalRequestCubit = GeneralRequestCubit(
        createGeneralRequestUsecase: getIt.get<CreateGeneralRequestUsecase>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RequestCubit(requestUsecase: getIt.get<RequestUsecase>()),
      child: BlocBuilder<RequestCubit, RequestsState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: const CustomAppbar(title: "Request"),
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration:
                    const BoxDecoration(gradient: AppColors.backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // AppbarWidget(title: "Request"),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.18),
                        CustomDropdown(
                          label: "Request type",
                          hint: "Select the request type",
                          items: requestList,
                          onChanged: (value) {
                            title = value ?? '';
                           
                          },
                          validator: (value) => value == null
                              ? "Please select a request type"
                              : null,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          hint: "Please enter the details here...",
                          label: "Details",
                          maxLines: 6,
                          onChanged: (value) {
                            details = value!;
                     
                          },
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        PrimaryButton(
                            label: "Send request",
                            onPressed: () async {
                              final model = RequestModel(
                                RequestType: title,
                                CustomerId: _userId,
                                Title: title,
                                Details: GeneralRequestModel(
                                  requestType: title,
                                  note: details
                                ),
                              );
                      
                              final request = await context
                                  .read<RequestCubit>()
                                  .createRequest(model);
                              if (request is DataFailed) {
                            
                                showHoveringSnackbar(
                                    context, "Failed to send request");
                              } else {
                     
                                showHoveringSnackbar(
                                    context, "Request sent successfully!");
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                await GoRouter.of(context)
                                    .pushNamed(Routes.navDashboard);
                              }
                            },
                            buttonStyleType: ButtonStyleType.filled)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
