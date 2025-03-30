import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/hotels_model/hotels_model.dart';
import 'package:bellagio_mobile_user/data/models/request_model/request_model.dart';
import 'package:bellagio_mobile_user/data/models/request_model/sub_models/hotel_reservation_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/hotels_usecase/get_hotels_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/request_usecase/request_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/requests/hotels_cubit/hotels_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/requests/requests_cubit/requests_cubit.dart';
import 'package:bellagio_mobile_user/presentation/routes/routes.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_date_picker.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_dropdown.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_snackbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/constants/request_types.dart';
import '../../../core/constants/style_manager.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/listDropdown.dart';
import '../../widgets/primary_button.dart';

class HotelReservation extends StatefulWidget {
  const HotelReservation({super.key});

  @override
  State<HotelReservation> createState() => _HotelReservationState();
}

class _HotelReservationState extends State<HotelReservation> {
  late RequestModel requestModel;
  String _userId = "";
  String _email = "";
  String _mobileNumber = "";
  String checkInDate = '';
  String name = "";
  String checkoutDate = "";
  HotelsModel? selectedHotel;
  String room = "Single Room";
  String note = "";
  final _formKey = GlobalKey<FormState>();
  final List<String> roomType = ["Single Room", "Double Room", "Suite"];
  ButtonState _buttonState = ButtonState.normal;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  void _getUserDetails() async {
    final sharedPrefManager = SharedPrefManager();
    final userId = await sharedPrefManager.getUserId();
    final username = await sharedPrefManager.getUserName();
    final email = await sharedPrefManager.getEmail();
    final mobileNumber = await sharedPrefManager.getPhoneNumber();

    if (userId != null) {
      setState(() {
        _userId = userId;
        name = username ?? '';
        _email = email ?? '';
        _mobileNumber = mobileNumber ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RequestCubit(requestUsecase: getIt.get<RequestUsecase>()),
        ),
        BlocProvider(
          create: (context) =>
              HotelsCubit(getHotelsUsecase: getIt.get<GetHotelsUsecase>())
                ..getHotels(),
        ),
      ],
      child: BlocBuilder<RequestCubit, RequestsState>(
        builder: (context, requestState) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              // extendBodyBehindAppBar: true,
              appBar: const CustomAppbar(
                title: "Hotel Reservation",
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
                            BlocBuilder<HotelsCubit, HotelsState>(
                              builder: (context, hotelsState) {
                                if (hotelsState is HotelsInitialState) {
                                  return const Center(
                                    child: CupertinoActivityIndicator(
                                      color: AppColors.dateTimeColor,
                                    ),
                                  );
                                } else if (hotelsState is HotelsErrorState) {
                                  return Center(
                                    child: Text(
                                      "Failed to load hotels.",
                                      style: getContentTextMedium(),
                                    ),
                                  );
                                } else if (hotelsState is HotelsLoadedState) {
                                  return DropDownList<HotelsModel>(
                                    label: "Hotels",
                                    hint: "Select a Hotel",
                                    dataList: hotelsState.hotelList,
                                    displayText: (hotel) => hotel.Name ?? '',
                                    customDecorator: (hotel) {
                                      int rating = hotel.Rating?.toInt() ?? 0;
                                      return Row(
                                        children: [
                                          const SizedBox(
                                              width:
                                                  8), // Add spacing between name and stars
                                          ...List.generate(
                                            rating,
                                            (index) => const Icon(
                                              Icons.star,
                                              color: AppColors.secondaryColor,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    onChanged: (value) {
                                      selectedHotel = value;
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select a hotel';
                                      }
                                      return null;
                                    },
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DatePicker(
                                  boxSize: BoxSize.short,
                                  title: "Check-in Date",
                                  hint: "Date",
                                  onDateSelected: (date) {
                                    setState(() {
                                      checkInDate = date;
                                    });
                                  },
                                  validator: (value) {
                                    if (checkInDate.isEmpty) {
                                      return 'Please select a date';
                                    }
                                    return null;
                                  },
                                ),
                                DatePicker(
                                  boxSize: BoxSize.short,
                                  title: "Check-out Date",
                                  hint: "Date",
                                  onDateSelected: (date) {
                                    setState(() {
                                      checkoutDate = date;
                                    });
                                  },
                                  validator: (value) {
                                    if (checkoutDate.isEmpty) {
                                      return 'Please select a date';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomDropdown(
                              label: "Room Type",
                              hint: "Select a room type",
                              items: roomType,
                              onChanged: (value) {
                                room = value ?? '';
                              },
                              validator: (value) => value == null
                                  ? "Please select a room type"
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            CustomTextfield(
                              hint: "Additional Requests",
                              label: "Additional Requests",
                              maxLines: 3,
                              onChanged: (value) {
                                note = value!;
                              },
                            ),
                            const SizedBox(height: 60),
                            PrimaryButton(
                              buttonState: _buttonState,
                              label: "Send Request",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  setState(() {
                                    _buttonState = ButtonState.loading;
                                    _isLoading = true;
                                  });
                                  final hotelReservation = HotelReservations(
                                    GuestName: name,
                                    // ContactNumber: _mobileNumber,
                                    Email: _email,
                                    HotelId: selectedHotel?.HotelId ?? '',
                                    HotelName: selectedHotel?.Name ?? '',
                                    CheckInDate: "$checkInDate 00:00:00",
                                    CheckOutDate: "$checkoutDate 00:00:00",
                                    RoomType: room,
                                  );
                                  final model = RequestModel(
                                    CustomerName: name,
                                    CustomerId: _userId,
                                    Title: hotelReservationRequest,
                                    Details: hotelReservation,
                                    RequestType: hotelReservationRequest,
                                    Descriptions: note,
                                    IsLongTrip: true
                                  );

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
                                      context,
                                      "Failed to create request.",
                                    );
                                  } else {
                                    await Future.delayed(
                                      const Duration(seconds: 2),
                                    );
                                    setState(() {
                                      _buttonState = ButtonState.success;
                                      _isLoading = false;
                                    });
                                    // showHoveringSnackbar(
                                    //   context,
                                    //   "Request sent successfully!",
                                    // );
                                    // setState(() {
                                    //   _buttonState = ButtonState.normal;
                                    // });

                                    GoRouter.of(context)
                                        .goNamed(Routes.navDashboard);
                                  }
                                }
                              },
                              buttonStyleType: ButtonStyleType.filled,
                            ),
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
