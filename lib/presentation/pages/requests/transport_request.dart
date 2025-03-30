import 'package:bellagio_mobile_user/data/models/request_model/sub_models/transport_request_model.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../core/constants/color_manager.dart';
import '../../../core/constants/request_types.dart';
import '../../../core/dependency_injection/service_locator.dart';
import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../../data/models/request_model/request_model.dart';
import '../../../domain/usecases/request_usecase/request_usecase.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_date_picker.dart';
import '../../widgets/custom_radio_button_list.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_time_picker.dart';
import '../../widgets/date_time_picker.dart';
import '../../widgets/primary_button.dart';
import 'requests_cubit/requests_cubit.dart';

class TransportRequest extends StatefulWidget {
  const TransportRequest({super.key});

  @override
  State<TransportRequest> createState() => _TransportRequestState();
}

class _TransportRequestState extends State<TransportRequest> {
  String _userId = "";
  String _userName = "";
  String _phone = "";
  String pickup = "";
  String dropOff = "";
  String vehicle = "Car";
  String trip = "Normal";
  String selectedDateTime = '';
  String selectedDate = "";
  String selectedTime = "";
  final _formKey = GlobalKey<FormState>();
  List<String> vehicleType = ["Car", "SUV", "Van"];
  List<String> tripType = ["Normal", "Long trip", "Luxury"];
  ButtonState _buttonState = ButtonState.normal;
  bool _isLoading = false;
  bool _isLongTrip = false;

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
    final phone = await sharedPrefManager.getPhoneNumber();
    if (userId != null && userName != null) {
      setState(() {
        _userId = userId;
        _userName = userName; // Assign the actual value, not the Future
        _phone = phone ?? "";
      });
    } else {}
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
              // extendBodyBehindAppBar: true,
              appBar: CustomAppbar(
                title: "Transport request",
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
                            CustomDropdown(
                                label: "Vehicle type",
                                hint: "Select a vehicle type",
                                items: vehicleType,
                                onChanged: (value) {
                                  vehicle = value ?? vehicle;
                                },
                                validator: (value) => value == null
                                    ? "Please select a vehicle"
                                    : null),
                            SizedBox(height: 10),
                            CustomRadioButtonList(
                              label: "Trip type",
                              options: tripType,
                              onChanged: (value) {
                                trip = value ?? 'Normal';
                                if (trip == 'Luxury' || trip == "Long trip") {
                                  setState(() {
                                    _isLongTrip = true;
                                  });
                                }
                              },
                              selectedValue: tripType.first,
                            ),
                            SizedBox(height: 10),
                            CustomTextfield(
                              hint: "Enter your pickup location",
                              label: "Pickup location",
                              onChanged: (value) {
                                pickup = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your pickup location';
                                }
                              },
                            ),
                            CustomTextfield(
                              hint: "Enter your destination",
                              label: "Drop off",
                              onChanged: (value) {
                                dropOff = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your destination';
                                }
                              },
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DatePicker(
                                    boxSize: BoxSize.short,
                                    title: "Date",
                                    hint: "Date",
                                    onDateSelected: (date) {
                                      setState(() {
                                        selectedDate = date;
                                      });
                                    },
                                    validator: (value) {
                                      if (selectedDate.isEmpty) {
                                        return 'Please select a date';
                                      }
                                      return null;
                                    },
                                  ),
                                  TimePicker(
                                    boxSize: BoxSize.short,
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
                                ]),
                            SizedBox(height: 60),
                            PrimaryButton(
                                label: "Send Request",
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    final _selectedDateTime =
                                        "${selectedDate} ${selectedTime}";
                                    final transportModel =
                                        TransportRequestModel(
                                            VehicleType: vehicle,
                                            PickupLocation: pickup,
                                            DropoffLocation: dropOff,
                                            PickupTime: _selectedDateTime,
                                            // CustomerPhone: _phone,
                                            TripType: trip);

                                    final model = RequestModel(
                                        CustomerName: _userName,
                                        CustomerId: _userId,
                                        Title: transportRequest,
                                        Details: transportModel,
                                        RequestType: transportRequest,
                                        IsLongTrip: _isLongTrip);
                                    final request = await context
                                        .read<RequestCubit>()
                                        .createRequest(model);

                                    if (request is DataFailed) {
                                      await Future.delayed(
                                        const Duration(seconds: 2),
                                      );
                                      setState(() {
                                        _buttonState = ButtonState.normal;
                                        _isLoading = false;
                                      });
                                      showHoveringSnackbar(
                                          context, "Failed to create request.");
                                    } else {
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                      GoRouter.of(context)
                                          .goNamed(Routes.navDashboard);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      // showHoveringSnackbar(
                                      //     context, "Request sent successfully!");
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
          );
        },
      ),
    );
  }
}
