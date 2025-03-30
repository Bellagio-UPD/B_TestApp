import 'package:bellagio_mobile_user/data/models/air_tickets_model/air_tickets_model.dart';
import 'package:bellagio_mobile_user/data/models/flow_type_model/flow_type_model.dart';
import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model_new.dart';
import 'package:bellagio_mobile_user/data/models/gifts_model/options_model.dart';
import 'package:bellagio_mobile_user/data/models/offers_model/offers_model.dart';
import 'package:bellagio_mobile_user/data/models/request_model/sub_models/deposit_details_model.dart';
import 'package:bellagio_mobile_user/data/models/request_model/sub_models/hotel_reservation_model.dart';
import 'package:bellagio_mobile_user/data/models/sign_up_model/sign_up_model.dart';
import 'package:bellagio_mobile_user/data/models/user_info_model/user_info_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/feedback_usecase/send_feedback_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/firebase_chat_usecase/get_message_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/firebase_chat_usecase/send_message_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/request_usecase/request_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/resend_otp_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/send_otp_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/validate_otp_usecase.dart';
import 'package:bellagio_mobile_user/main.dart';
import 'package:bellagio_mobile_user/presentation/pages/air_ticket/air_ticket_boarding_pass.dart';
import 'package:bellagio_mobile_user/presentation/pages/chat/chat.dart';
import 'package:bellagio_mobile_user/presentation/pages/chat/chat_cubit/chat_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/chat/chat_options.dart';
import 'package:bellagio_mobile_user/presentation/pages/feedback/feddback_screen.dart';
import 'package:bellagio_mobile_user/presentation/pages/my_cards/my_cards.dart';
import 'package:bellagio_mobile_user/presentation/pages/navigationBar/navbar_dashboard.dart';
import 'package:bellagio_mobile_user/presentation/pages/packages/payment_mode.dart';
import 'package:bellagio_mobile_user/presentation/pages/profile/profile.dart';
import 'package:bellagio_mobile_user/presentation/pages/requests/air_ticket_request/air_ticket_request.dart';
import 'package:bellagio_mobile_user/presentation/pages/entertainment/entertainment.dart';
import 'package:bellagio_mobile_user/presentation/pages/general_request/general_request.dart';
import 'package:bellagio_mobile_user/presentation/pages/gifts/gifts_screen.dart';
import 'package:bellagio_mobile_user/presentation/pages/home/home_screen.dart';
import 'package:bellagio_mobile_user/presentation/pages/notifications/notifications.dart';
import 'package:bellagio_mobile_user/presentation/pages/offers/offers_screen.dart';
import 'package:bellagio_mobile_user/presentation/pages/packages/packages_screen.dart';
import 'package:bellagio_mobile_user/presentation/pages/requests/requests_cubit/requests_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/rewards/rewards_screen.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_in/forgot_password.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_in/sign_in.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_in/sign_in_cubit/sign_in_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/enter_mobile_number.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/otp_cubit/otp_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/otp_screen.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/sign_up.dart';
import 'package:bellagio_mobile_user/presentation/pages/splash_screen/splash_screen.dart';
import 'package:bellagio_mobile_user/presentation/pages/tournemants/tournaments_screen.dart';
import 'package:bellagio_mobile_user/presentation/pages/requests/transport_request.dart';
import 'package:bellagio_mobile_user/presentation/pages/video_player/video_player.dart';
import 'package:bellagio_mobile_user/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/dependency_injection/service_locator.dart';
import '../../data/sources/hive_storage_service/hive_storage_serive.dart';
import '../../domain/usecases/file_download_usecase/file_download_usecase.dart';
import '../../domain/usecases/forgot_password_usecase/forgot_password_usecase.dart';
import '../../domain/usecases/general_request_usecase/general_request_usecase.dart';
import '../../domain/usecases/sign_up_usecase/sign_up_usecase.dart';
import '../../domain/usecases/user_info_usecase/user_info_usecase.dart';
import '../pages/air_ticket/air_ticket.dart';
import '../pages/chat/file_download_cubit/file_download_cubit.dart';
import '../pages/feedback/feedback_cubit/feedback_cubit.dart';
import '../pages/general_request/general_request_cubit/general_request_cubit.dart';
import '../pages/gifts/view_gifts_screen.dart';
import '../pages/home/home_screen_cubit/user_info_cubit.dart';
import '../pages/requests/hotel_reservation.dart';
import '../pages/requests/money_deposit/money_deposit.dart';
import '../pages/offers/offer.dart';
import '../pages/sign_in/forgot_password_cubit/forgot_password_cubit.dart';
import '../pages/sign_up/sign_up_cubit/sign_up_cubit.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  final GoRouter goRouterConfig = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
            name: Routes.initial,
            path: '/',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return MaterialPage(child: SplashScreen());
            }),

        // Additional routes

        GoRoute(
          name: Routes.navDashboard,
          path: '/navbar_dashboard',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: NavbarDashboard(
                    // model: state.extra as FlowTypeWrapperModel,
                    ));
          },
        ),
        GoRoute(
          name: Routes.splash_screen,
          path: '/splash_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage(child: SplashScreen());
          },
        ),
        GoRoute(
          name: Routes.signIn,
          path: '/sign_in',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: BlocProvider(
              create: (context) =>
                  UserInfoCubit(userInfoUsecase: getIt.get<UserInfoUsecase>()),
              child: SignIn(),
            ));
          },
        ),
        GoRoute(
          name: Routes.forgotPassword,
          path: '/forgot_password',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: BlocProvider(
              create: (context) => ForgotPasswordCubit(
                  forgotPasswordUsecase: getIt.get<ForgotPasswordUsecase>()),
              child: ForgotPasswordScreen(
                model: state.extra as FlowTypeWrapperModel,
              ),
            ));
          },
        ),
        GoRoute(
          name: Routes.signUp,
          path: '/sign_up',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      SignUpCubit(signUpUsecase: getIt.get<SignUpUsecase>()),
                ),
                BlocProvider(
                  create: (context) => UserInfoCubit(
                      userInfoUsecase: getIt.get<UserInfoUsecase>()),
                ),
              ],
              child: SignUp(
                flowTypeWrapperModel: state.extra as FlowTypeWrapperModel,
              ),
            ));
          },
        ),
        GoRoute(
          name: Routes.enterMobileNumber,
          path: '/enter_mobile_number',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
              child: BlocProvider(
                create: (context) =>
                    OtpCubit(sendOtpUsecase: getIt.get<SendOtpUsecase>()),
                child: EnterMobileNumberScreen(
                  flowTypeWrapperModel: state.extra as FlowTypeWrapperModel,
                  // signUpModel: state.extra as SignUpModel,
                ),
              ),
            );
          },
        ),
        GoRoute(
          name: Routes.enterOtp,
          path: '/otp_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => OtpCubit(
                      resendOtpUsecase: getIt.get<ResendOtpUsecase>(),
                      validateOtpUsecase: getIt.get<ValidateOtpUsecase>()),
                ),
                BlocProvider(
                  create: (context) =>
                      SignUpCubit(signUpUsecase: getIt.get<SignUpUsecase>()),
                ),
              ],
              child: EnterOtpScreen(
                flowTypeWrapperModel: state.extra as FlowTypeWrapperModel,
              ),
            ));
          },
        ),
        GoRoute(
          name: Routes.home,
          path: '/home_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: HomeScreen(
                    // model: state.extra as FlowTypeWrapperModel,
                    ));
          },
        ),
        GoRoute(
          name: Routes.notifications,
          path: '/notifications',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(child: NotificationsScreen());
          },
        ),
        GoRoute(
          name: Routes.profile,
          path: '/profile_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(child: ProfileScreen());
          },
        ),
        GoRoute(
          name: Routes.entertainment,
          path: '/entertainment',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return  MaterialPage(child: EntertainmentScreen());
          },
        ),
        GoRoute(
          name: Routes.gifts,
          path: '/gifts_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage(child: GiftsScreen());
          },
        ),
        GoRoute(
          name: Routes.rewards,
          path: '/rewards_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage(child: RewardsScreen());
          },
        ),
        GoRoute(
          name: Routes.tournaments,
          path: '/tournaments_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return  MaterialPage(child: TournamentsScreen());
          },
        ),
        GoRoute(
          name: Routes.packages,
          path: '/packages_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(child: PackagesScreen());
          },
        ),
        GoRoute(
          name: Routes.offersScreen,
          path: '/offers_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(child: OffersScreen());
          },
        ),
        GoRoute(
          name: Routes.offer,
          path: '/offer',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: Offer(offer: state.extra as OffersModel));
          },
        ),
        GoRoute(
          name: Routes.generalRequest,
          path: '/general_request',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: BlocProvider(
                    create: (context) => GeneralRequestCubit(
                        createGeneralRequestUsecase:
                            getIt.get<CreateGeneralRequestUsecase>()),
                    child: const GeneralUserRequest()));
          },
        ),
        GoRoute(
          name: Routes.airTicketScreen,
          path: '/air_ticket',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage(child: AirTicketScreen());
          },
        ),
        GoRoute(
          name: Routes.boardingPass,
          path: '/air_ticket_boarding_pass',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: AirTicketBoardingPass(
              airTicketModel: state.extra as AirTicketModel,
            ));
          },
        ),
        GoRoute(
          name: Routes.transportRequest,
          path: '/transport_request',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage(child: TransportRequest());
          },
        ),
        GoRoute(
          name: Routes.airTicketRequest,
          path: '/air_ticket_request',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(child: AirTicketRequest());
          },
        ),
        GoRoute(
          name: Routes.moneyDeposit,
          path: '/money_deposit',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: BlocProvider(
              create: (context) =>
                  RequestCubit(requestUsecase: getIt.get<RequestUsecase>()),
              child: MoneyDeposit(
                depositModel: state.extra as DepositDetails,
              ),
            ));
          },
        ),
        GoRoute(
          name: Routes.hotelReservation,
          path: '/hotel_reservation',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage(child: HotelReservation());
          },
        ),
        GoRoute(
          name: Routes.paymentMode,
          path: '/payment_mode',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: PaymentMode(
              depositDetails: state.extra as DepositDetails,
            ));
          },
        ),
        GoRoute(
          name: Routes.myCards,
          path: '/my_cards',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(child: MyCards());
          },
        ),
        GoRoute(
          name: Routes.videoPlayerScreen,
          path: '/video_player_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: SuccessVideoPlayer(
              videoAsset: 'assets/videos/LandingVideo-Ballagio.mp4',
            ));
          },
        ),
        GoRoute(
          name: Routes.feedback,
          path: '/feddback_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child: BlocProvider(
              create: (context) => FeedbackCubit(
                  sendFeedbackUsecase: getIt.get<SendFeedbackUsecase>()),
              child: FeedbackScreen(),
            ));
          },
        ),
        GoRoute(
          name: Routes.chat,
          path: '/chat/:salesRefId/:customerId/:salesRefName/:customerName',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final salesRefId = state.pathParameters['salesRefId']!;
            final customerId = state.pathParameters['customerId']!;
            final salesRefName = state.pathParameters['salesRefName']!;
            final customerName = state.pathParameters['customerName']!;
            return MaterialPage(
              child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => ChatCubit(
                        streamMessagesUseCase:
                            getIt.get<StreamMessagesUseCase>(),
                        sendMessageUseCase: getIt.get<SendMessageUseCase>(),
                      ),
                    ),
                    BlocProvider(
                      create: (context) => FileDownloadCubit(
                        fileDownloadUsecase: getIt.get<FileDownloadUsecase>(),
                      ),
                    ),
                  ],
                  child: ChatPage(
                      salesRefId: salesRefId,
                      customerId: customerId,
                      salesRefName: salesRefName,
                      customerName: customerName,)),
            );
          },
        ),
        GoRoute(
          name: Routes.viewGifts,
          path: '/view_gifts',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(
                child:
                    ViewGiftsScreen(giftModel: state.extra as GiftsModelNew));
          },
        ),
        GoRoute(
          name: Routes.chatOptions,
          path: '/chat_options_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(child: ChatOptionsScreen());
          },
        ),
      ]);
}
