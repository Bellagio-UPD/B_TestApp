import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/request_types.dart';
import '../../../../core/constants/style_manager.dart';
import '../../../../core/storage/data_state.dart';
import '../../../../core/storage/shared_pref_manager.dart';
import '../../../../data/models/airports_model/airports_model.dart';
import '../../../../data/models/request_model/request_model.dart';
import '../../../../data/models/request_model/sub_models/air_ticket_booking_model.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/primary_button.dart';
import '../requests_cubit/requests_cubit.dart';

class RoundTripTicket extends StatefulWidget {
  RoundTripTicket({super.key});

  @override
  State<RoundTripTicket> createState() => _RoundTripTicketState();
}

class _RoundTripTicketState extends State<RoundTripTicket> {
  String _userId = "";
  String name = "";
  String departureDate = "";
  String returnDate = "";
  String departureAirport = "";
  String destinationAirport = "Custom";
  String flightClass = "Business Class";
  String? note = "";
  String selectedOption = "";
  final _formKey = GlobalKey<FormState>();
  List<String> arrivals = ["Colombo"];
  List<String> flightClasses = [
    "Business Class",
    "First Class",
    "Premium Economy",
    "Economy Class"
  ];
  TextEditingController nameController = TextEditingController();
  bool _isLoading = false;
  RegExp stringValidation = RegExp(r'^[a-zA-Z\s]+$');

  @override
  void initState() {
    super.initState();
    selectedOption = "Round trip";
    _getUserId();
  }

  void _getUserId() async {
    final sharedPrefManager = SharedPrefManager();
    final userId =
        await sharedPrefManager.getUserId(); // Resolve the Future here
    final userName = await sharedPrefManager.getUserName();
    if (userId != null) {
      setState(() {
        _userId = userId; // Assign the actual value, not the Future
        // nameController.text = userName ?? '';
        nameController = TextEditingController(text: userName);
        name = userName ?? '';
      });
    } else {}
  }

  String extractAirportName(AirportModel airportModel) {
    return airportModel.airport!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              // SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              // AppbarWidget(title: "Air ticket request"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        hint: "Departing",
                        label: "Departure Airport/City",
                        // maxLines: 3,
                        onChanged: (value) {
                          departureAirport = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an airport.';
                          } else if (!stringValidation.hasMatch(value)) {
                            return "Please enter a valid airport.";
                          }
                          return null;
                        },
                      ),
                      CustomDropdown(
                        label: "Arrival",
                        hint: "Arrival Airport/City",
                        items: arrivals,
                        onChanged: (value) {
                          destinationAirport = value ?? '';
                        },
                        validator: (value) =>
                            value == null ? "Please select an arrival" : null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DatePicker(
                            boxSize: BoxSize.short,
                            title: "Departure date",
                            hint: "Date",
                            onDateSelected: (date) {
                              setState(() {
                                departureDate = date; // Capture selected date
                              });
                            },
                            validator: (value) {
                              if (departureDate.isEmpty) {
                                return 'Please select a date'; // Validate in parent
                              }
                              return null;
                            },
                            onSaved: (value) {
                              departureDate = value!; // Save selected date
                            },
                          ),
                          DatePicker(
                            boxSize: BoxSize.short,
                            title: "Return date",
                            hint: "Date",
                            enabled: selectedOption ==
                                "Round trip", // Disable when "One way" is selected
                            onDateSelected: (date) {
                              setState(() {
                                returnDate = date; // Capture selected date
                              });
                            },
                            validator: (value) {
                              if (selectedOption == "Round trip" &&
                                  returnDate.isEmpty) {
                                return 'Please select a return date'; // Validate return date when round trip is selected
                              }
                              return null;
                            },
                            onSaved: (value) {
                              returnDate = value!; // Save selected date
                            },
                          ),
                        ],
                      ),
                      CustomDropdown(
                        label: "Preffered class",
                        hint: "Select the class",
                        items: flightClasses,
                        onChanged: (value) {
                          flightClass = value ?? '';
                        },
                        validator: (value) =>
                            value == null ? "Please select a class" : null,
                      ),
                      CustomTextfield(
                        hint: "Additional requests",
                        label: "Additional requests",
                        maxLines: 3,
                        onChanged: (value) {
                          note = value!;
                        },
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      PrimaryButton(
                          label: "Send Request",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() {
                                _isLoading = true;
                              });
                              final airTicketBooking = AirTicketBookingModel(
                                TripType: "Round Trip",
                                DepartureAirport: departureAirport,
                                ArrivalAirport: destinationAirport,
                                DepartureDate: "${departureDate} 00:00:00",
                                ArrivalDate: "${returnDate} 00:00:00",
                                Class: flightClass,
                                // note: note.
                              );

                              final model = RequestModel(
                                  IsLongTrip: true,
                                  CustomerName: name,
                                  CustomerId: _userId,
                                  Title: airTicketRequest,
                                  Details: airTicketBooking,
                                  RequestType: airTicketRequest,
                                  Descriptions: note);
                              final request = await context
                                  .read<RequestCubit>()
                                  .createRequest(model);
                              if (request is DataFailed) {
                                setState(() {
                                  _isLoading = false;
                                });
                                showHoveringSnackbar(
                                    context, "Failed to create request.");
                              } else {
                                // showHoveringSnackbar(
                                //     context, "Request sent successfully!");
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                GoRouter.of(context)
                                    .goNamed(Routes.navDashboard);
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                          buttonStyleType: ButtonStyleType.filled),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
            ],
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
      ],
    );
  }
}
