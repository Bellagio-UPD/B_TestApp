import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/feedback_model/feedback_model.dart';
import 'package:bellagio_mobile_user/data/models/feedback_model/feedback_table_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/feedback_usecase/get_feedbackTable_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/feedback_usecase/send_feedback_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/feedback/feedback_cubit/feedback_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/listDropdown.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/storage/shared_pref_manager.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_textfield.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  // Controllers
  final TextEditingController _tableNumberController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Star ratings
  int gamingServicesRating = 0;
  int frontOfficeRating = 0;
  int fAndBServicesRating = 0;
  int tableNstaff = 0;

  String details = "";
  String tableNumber = "";
  String _userId = "";

  final _formKey = GlobalKey<FormState>();
  RegExp intValidation = RegExp(r'^\d+$');
  bool _isLoading = false;
  String _game = "";
  List<String> _tables = [];
  bool isDropdownDisabled = false;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  void _getUserId() async {
    final sharedPrefManager = SharedPrefManager();
    final userId = await sharedPrefManager.getUserId();
    if (userId != null) {
      setState(() {
        _userId = userId;
      });
    } else {}
  }

  Row _buildRatingRow(String title, int rating, Function(int) onRatingChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 4,
          child: Text(
            title,
            style: getContentTextLarge(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          flex: 3,
          child: Wrap(
            spacing: 3.0,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => onRatingChanged(index + 1),
                child: GradientIcon(
                  offset: Offset.fromDirection(0),
                  icon: index < rating ? Icons.star : Icons.star_border,
                  gradient: index < rating
                      ? AppColors.accentColor
                      : AppColors.accentColor,
                  size: 25,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _submitFeedback() async {
    setState(() {
      _isLoading = true;
    });

    final feedbackModel = FeedbackModel(
        FeedbackId: "",
        TableNumber: tableNumber.toString(),
        GamingServiceRating: gamingServicesRating,
        FandBServiceRating: fAndBServicesRating,
        FrontOfficeRating: frontOfficeRating,
        TableNStaffRating: tableNstaff,
        Content: details,
        CustomerId: _userId,
        deleted: false);

    final response =
        await context.read<FeedbackCubit>().createFeedback(feedbackModel);
    if (response is DataFailed) {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isLoading = false;
      });
      showHoveringSnackbar(context, "Failed to send feedback");
    } else {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isLoading = false;
      });

      GoRouter.of(context).goNamed(Routes.navDashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackCubit(
          sendFeedbackUsecase: getIt.get<SendFeedbackUsecase>(),
          getFeedbacktableUsecase: getIt.get<GetFeedbacktableUsecase>())
        ..getTableNGames(),
      child: BlocBuilder<FeedbackCubit, FeedbacksState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: const CustomAppbar(title: "Feedback"),
              body: Stack(children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: AppColors.backgroundColor,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            BlocBuilder<FeedbackCubit, FeedbacksState>(
                                builder: (context, state) {
                              if (state is FeedbackTableInitialState) {
                                return Center(
                                  child: CupertinoActivityIndicator(
                                    color: AppColors.dateTimeColor,
                                  ),
                                );
                              } else if (state is FeedbackTableErrorState) {
                                return Center(
                                  child: Text(
                                    "Failed to load games.",
                                    style: getContentTextMedium(),
                                  ),
                                );
                              } else if (state is FeedbackTableSuccessState) {
                                final gameList = state.feedbackTableModel!
                                    .map((e) => e.game!.name ?? "")
                                    .toList();

                                return Column(
                                  children: [
                                    DropDownList<dynamic>(
                                      label: "Games",
                                      hint: "Select games",
                                      dataList: gameList,
                                      displayText: (game) => game ?? '',
                                      selectedItem: _game,
                                      onChanged: isDropdownDisabled
                                          ? null
                                          : (value) {
                                              setState(() {
                                                _game = value;
                                                tableNumber =
                                                    ""; // Reset table when game changes
                                                _tables = [];
                                                isDropdownDisabled =
                                                    false; // Enable dropdowns again

                                                final selectedGame = state
                                                        .feedbackTableModel
                                                        ?.firstWhere(
                                                      (element) =>
                                                          element.game!.name ==
                                                          value,
                                                      orElse: () =>
                                                          FeedbackTableModel(),
                                                    ) ??
                                                    FeedbackTableModel();

                                                _tables = selectedGame.tables !=
                                                        null
                                                    ? selectedGame.tables!
                                                        .map((e) =>
                                                            e.tableNumber ?? '')
                                                        .toList()
                                                    : [];
                                              });
                                            },
                                      readOnly: isDropdownDisabled,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select a game';
                                        }
                                        return null;
                                      },
                                    ),
                                    if (_game != null && _tables.isNotEmpty)
                                      DropDownList<dynamic>(
                                        label: "Tables",
                                        hint: "Select a table",
                                        dataList: _tables,
                                        displayText: (table) => table ?? '',
                                        selectedItem: tableNumber.isNotEmpty
                                            ? tableNumber
                                            : null,
                                        onChanged: isDropdownDisabled
                                            ? null
                                            : (value) {
                                                setState(() {
                                                  tableNumber = value;
                                                  isDropdownDisabled =
                                                      true; // Disable both dropdowns once selected
                                                });
                                              },
                                        readOnly: isDropdownDisabled,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a table';
                                          }
                                          return null;
                                        },
                                      ),
                                  ],
                                );
                              }
                              return Center(
                                child: CupertinoActivityIndicator(
                                  color: AppColors.dateTimeColor,
                                ),
                              );
                            }),
                            const SizedBox(height: 20),

                            // Gaming Services Rating
                            _buildRatingRow(
                              "Gaming Services",
                              gamingServicesRating,
                              (rating) =>
                                  setState(() => gamingServicesRating = rating),
                            ),

                            const SizedBox(height: 30),

                            // Front Office Services Rating
                            _buildRatingRow(
                              "Front Office Services",
                              frontOfficeRating,
                              (rating) =>
                                  setState(() => frontOfficeRating = rating),
                            ),

                            const SizedBox(height: 30),

                            // F&B Services Rating
                            _buildRatingRow(
                              "F&B Services",
                              fAndBServicesRating,
                              (rating) =>
                                  setState(() => fAndBServicesRating = rating),
                            ),

                            const SizedBox(height: 30),

                            // Transportation Services Rating
                            _buildRatingRow(
                              "Table and Staff Service",
                              tableNstaff,
                              (rating) => setState(() => tableNstaff = rating),
                            ),

                            const SizedBox(height: 20),

                            // Notes Section
                            CustomTextfield(
                              hint: "Please enter any additional notes here...",
                              label: "Notes",
                              maxLines: 4,
                              onChanged: (value) {
                                details = value!;
                              },
                            ),

                            const SizedBox(height: 40),

                            PrimaryButton(
                              label: "Submit",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (gamingServicesRating == 0 ||
                                      frontOfficeRating == 0 ||
                                      fAndBServicesRating == 0 ||
                                      tableNstaff == 0) {
                                    showHoveringSnackbar(context,
                                        "Please provide ratings for all categories.");
                                    return;
                                  }
                                  _formKey.currentState!.save();
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  _submitFeedback();
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
