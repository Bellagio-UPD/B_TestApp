import 'package:bellagio_mobile_user/data/models/air_tickets_model/air_tickets_model.dart';
import 'package:bellagio_mobile_user/data/repository_impl/air_ticket_repository_impl/air_ticket_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/airports_repository_impl/airports_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/deposits_repository_impl/deposits_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/events_repository_impl/events_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/fcm_token_register_repository_impl/fcm_token_register_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/feedback_repository_impl/feedback_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/file_download_repository_impl/file_download_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/firebase_chat_repository_impl/chat_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/forgot_password_repository_impl/forgot_password_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/gifts_repository_impl/gifts_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/hotels_repository_impl/hotels_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/login_user_repository_impl/login_user_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/loyalty_cards_repository_impl/loyalty_cards_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/managerId_repository_impl/managerId_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/notifications_repository_impl/notifications_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/offers_repository_impl/offers_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/packages_repository_impl/packages_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/request_repository_impl/request_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/send_otp_repository_impl/send_otp_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/sign_up_repository_impl/sign_up_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/tournaments_repository_impl/tournaments_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/update_profile_image_repository_impl/update_profile_image_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/user_info_repository_impl/user_info_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/verify_mobile_repository_impl/verify_mobile_repository_impl.dart';
import 'package:bellagio_mobile_user/data/repository_impl/withdrawal_repository_impl/withdrawal_repository_impl.dart';
import 'package:bellagio_mobile_user/data/sources/air_tickets_service/air_tickets_service.dart';
import 'package:bellagio_mobile_user/data/sources/airports_service/airports_service.dart';
import 'package:bellagio_mobile_user/data/sources/events_service/events_service.dart';
import 'package:bellagio_mobile_user/data/sources/fcm_token_register_repository_service/fcm_token_register_repository_service.dart';
import 'package:bellagio_mobile_user/data/sources/feedback_service/feedback_service.dart';
import 'package:bellagio_mobile_user/data/sources/feedback_service/feedback_table_service.dart';
import 'package:bellagio_mobile_user/data/sources/file_uploader_service.dart/file_uploader_service.dart';
import 'package:bellagio_mobile_user/data/sources/forgot_password_service/forgot_password_service.dart';
import 'package:bellagio_mobile_user/data/sources/general_request_service/general_request_service.dart';
import 'package:bellagio_mobile_user/data/sources/gifts_service/gifts_service.dart';
import 'package:bellagio_mobile_user/data/sources/login_service/login_service.dart';
import 'package:bellagio_mobile_user/data/sources/loyalty_cards_service/loyalty_cards_service.dart';
import 'package:bellagio_mobile_user/data/sources/notifications_service/notifications_service.dart';
import 'package:bellagio_mobile_user/data/sources/notifications_service/notifications_socket_service.dart';
import 'package:bellagio_mobile_user/data/sources/offers_service/offers_service.dart';
import 'package:bellagio_mobile_user/data/sources/otp_service/otp_service.dart';
import 'package:bellagio_mobile_user/data/sources/packages_service.dart/packages_service.dart';
import 'package:bellagio_mobile_user/data/sources/redeem_qr_code_service/redeem_qr_code_service.dart';
import 'package:bellagio_mobile_user/data/sources/request_service/request_service.dart';
import 'package:bellagio_mobile_user/data/sources/sign_up_service/sign_up_service.dart';
import 'package:bellagio_mobile_user/data/sources/tournaments_service/tournaments_service.dart';
import 'package:bellagio_mobile_user/data/sources/update_profile_image_service/update_profile_image_service.dart';
import 'package:bellagio_mobile_user/data/sources/user_info_service/manager_id_service.dart';
import 'package:bellagio_mobile_user/data/sources/user_info_service/user_info_service.dart';
import 'package:bellagio_mobile_user/data/sources/verify_mobile_number_service/verify_mobile_number_service.dart';
import 'package:bellagio_mobile_user/data/sources/withdrawal_service/withdrawal_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/air_tickets_repository/air_tickets_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/airports_repository/airports_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/deposits_repository/deposits_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/events_repository/events_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/fcm_token_register_repository/fcm_token_register_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/feedback_repository/feedback_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/file_download_repository/file_download_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/file_uploader_repository/file_uploader_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/firebase_chat_repository/chat_summary_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/firebase_chat_repository/firebase_chat.dart';
import 'package:bellagio_mobile_user/domain/repositories/forgot_password_repository/forgot_password_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/general_request_repository/general_request_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/gifts_repository/gifts_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/hotels_repository/hotels_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/login_user_repository/login_user_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/loyalty_cards_repository/loyalty_cards_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/manager_id_repository/manager_id_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/notifications_repository/notifications_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/offers_repository/offers_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/packages_repository/packages_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/request_repository/request_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/sign_up_repository/sign_up_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/tournaments_repository/tournaments_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/user_info_repository/user-info_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/verify_mobile_number_repository/verify_mobile_number_repository.dart';
import 'package:bellagio_mobile_user/domain/repositories/withdrawal_repository/withdrawal_repository.dart';
import 'package:bellagio_mobile_user/domain/usecases/air_tickets_ucecase/get_air_tickets_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/airports_usecase/get_airports_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/deposits_usecase/get_deposits_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/events_usecase/get_events_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/fcm_register_usecase/fcm_token_register_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/feedback_usecase/send_feedback_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/file_uploader_usecase/file_uploader_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/firebase_chat_usecase/fetch_summary_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/firebase_chat_usecase/get_message_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/firebase_chat_usecase/send_message_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/forgot_password_usecase/forgot_password_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/general_request_usecase/general_request_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/gifts_usecase/get_gifts_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/gifts_usecase/redeem_gift_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/hotels_usecase/get_hotels_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/login_user_usecase.dart/login_user_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/loyalty_cards_usecase/get_assigned_loyalty_card_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/loyalty_cards_usecase/get_loyalty_cards_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/manager_id_usecase/get-managerId_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/notifications_usecase/get_notifications_by_socket_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/notifications_usecase/get_notifications_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/offers_usecase/get_offers_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/packages_usecase/get_package_by_package_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/packages_usecase/get_packages_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/request_usecase/request_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/tournaments_usecase/get_tournaments_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/update_profile_image_usecase/update_profile_image.dart';
import 'package:bellagio_mobile_user/domain/usecases/user_info_usecase/user_info_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/resend_otp_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/send_otp_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/validate_otp_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/sign_up_usecase/sign_up_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/verify_mobile_number_usecase/verify_mobile_number_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/withdrawal_usecase/get_withdrawal_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../data/repository_impl/file_uploader_repository_impl/file_uploader_repository.dart';
import '../../data/repository_impl/firebase_chat_repository_impl/chat_summary_repository_impl.dart';
import '../../data/repository_impl/general_request_repository_impl/general_request_repository_impl.dart';
import '../../data/sources/deposits_service/deposits_service.dart';
import '../../data/sources/file_download_service/file_download_service.dart';
import '../../data/sources/hive_storage_service/hive_storage_serive.dart';
import '../../data/sources/hotels_service/hotels_service.dart';
import '../../data/sources/location_service/location_service.dart';
import '../../domain/repositories/otp_repository/otp_repository.dart';
import '../../domain/repositories/update_profile_image_repository/update_profile_image_repository.dart';
import '../../domain/usecases/feedback_usecase/get_feedbackTable_usecase.dart';
import '../../domain/usecases/file_download_usecase/file_download_usecase.dart';
import '../network/token_interceptor.dart';
import '../storage/shared_pref_manager.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPrefManager = SharedPrefManager();
  getIt.registerSingleton<SharedPrefManager>(sharedPrefManager);
  await sharedPrefManager.getToken();

  final dio = Dio();
  dio.interceptors.add(TokenInterceptor(
    sharedPrefManager: sharedPrefManager,
  ));
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    logPrint: (object) => print(object),
  ));

  getIt.registerSingleton<Dio>(dio);

  getIt.registerLazySingleton(() => LocationService());

  // API's

  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  getIt.registerLazySingleton<LoginService>(() => LoginService(getIt()));
  getIt.registerLazySingleton<GeneralRequestService>(
      () => GeneralRequestService(getIt()));
  getIt.registerLazySingleton<SignUpService>(() => SignUpService(getIt()));
  getIt.registerLazySingleton<OtpService>(() => OtpService(getIt()));
  getIt.registerLazySingleton<RequestService>(() => RequestService(getIt()));
  getIt.registerLazySingleton<UserInfoService>(() => UserInfoService(getIt()));
  getIt.registerLazySingleton<PackagesService>(() => PackagesService(getIt()));
  getIt.registerLazySingleton<GiftsService>(() => GiftsService(getIt()));
  getIt.registerLazySingleton<OffersService>(() => OffersService(getIt()));
  getIt.registerLazySingleton<LoyaltyCardsService>(
      () => LoyaltyCardsService(getIt()));
  getIt.registerLazySingleton(() => EventsService(getIt()));
  getIt.registerLazySingleton<TournamentsService>(
      () => TournamentsService(getIt()));
  getIt.registerLazySingleton<AirTicketsService>(
      () => AirTicketsService(getIt()));
  getIt.registerLazySingleton<AirportsService>(() => AirportsService(getIt()));
  getIt.registerLazySingleton<FeedbackService>(() => FeedbackService(getIt()));
  getIt.registerLazySingleton<ForgotPasswordService>(
      () => ForgotPasswordService(getIt()));
  getIt.registerLazySingleton<VerifyMobileNumberService>(
      () => VerifyMobileNumberService(getIt()));
  getIt.registerLazySingleton<FileUploaderService>(
      () => FileUploaderService(getIt()));
  getIt.registerLazySingleton<HotelsService>(() => HotelsService(getIt()));
  getIt.registerLazySingleton<DepositsService>(() => DepositsService(getIt()));
  getIt.registerLazySingleton<WithdrawalService>(
      () => WithdrawalService(getIt()));
  getIt.registerLazySingleton<NotificationsService>(
      () => NotificationsService(getIt()));
  getIt.registerLazySingleton<FileDownloadService>(
      () => FileDownloadService(getIt()));
  getIt.registerLazySingleton<NotificationsSocketService>(() =>
      NotificationsSocketService(
          url:
              'wss://notificationmanagement-app1750.demo.cgaas.ai/ws/notifications'));
  getIt.registerLazySingleton<RedeemQrCodeService>(
      () => RedeemQrCodeService(getIt()));
  getIt.registerLazySingleton<FCMRegisterRequestService>(
      () => FCMRegisterRequestService(getIt()));
  getIt.registerLazySingleton<UpdateProfileImageService>(
      () => UpdateProfileImageService(getIt()));
  getIt.registerSingleton<HiveStorageService>(HiveStorageService());
  getIt.registerLazySingleton<FeedbackTableService>(
      () => FeedbackTableService(getIt()));
  getIt
      .registerLazySingleton<ManagerIdService>(() => ManagerIdService(getIt()));

  // Repositories and RepositoryImpl
  getIt.registerLazySingleton<FileDownloadRepository>(
      () => FileDownloadRepositoryImpl(getIt()));
  getIt.registerLazySingleton<LoginUserRepository>(
      () => LoginUserRepositoryImpl(getIt()));
  getIt.registerLazySingleton<GeneralRequestRepository>(
      () => GeneralRequestRepositoryImpl(getIt()));
  getIt.registerLazySingleton<SignUpRepository>(
      () => SignUpRepositoryImpl(getIt()));
  getIt.registerLazySingleton<OtpRepository>(
      () => ValidateOtpRepositoryImpl(getIt()));
  getIt.registerLazySingleton<RequestRepository>(
      () => RequestRepositoryImpl(getIt()));
  getIt.registerLazySingleton<GetUserInfoRepository>(
      () => UserInfoRepositoryImpl(getIt()));
  getIt.registerLazySingleton<PackagesRepository>(
      () => PackagesRepositoryImpl(getIt()));
  getIt.registerLazySingleton<GiftsRepository>(
      () => GiftsRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<OffersRepository>(
      () => OffersRepositoryImpl(getIt()));
  getIt.registerLazySingleton<LoyaltyCardsRepository>(
      () => LoyaltyCardsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<EventsRepository>(
      () => EventsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<TournamentsRepository>(
      () => TournamentsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<AirTicketsRepository>(
      () => AirTicketRepositoryImpl(getIt()));
  getIt.registerLazySingleton<AirportsRepository>(
      () => AirportsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<FeedbackRepository>(
      () => FeedbackRepositoryImpl(getIt(), getIt()));
  getIt
      .registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(getIt()));
  getIt.registerLazySingleton<ChatSummaryRepository>(
      () => ChatSummaryRepositoryImpl(getIt()));
  getIt.registerLazySingleton<ForgotPasswordRepository>(
      () => ForgotPasswordRepositoryImpl(getIt()));
  getIt.registerLazySingleton<VerifyMobileNumberRepository>(
      () => VerifyMobileRepositoryImpl(getIt()));
  getIt.registerLazySingleton<FileUploaderRepository>(
      () => UploadProfileImageImpl(getIt()));
  getIt.registerLazySingleton<HotelsRepository>(
      () => HotelsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<WithdrawalRepository>(
      () => WithdrawalRepositoryImpl(getIt()));
  getIt.registerLazySingleton<DepositsRepository>(
      () => DepositsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<FCMRegisterRequestRepository>(
      () => FCMRegisterRequestRepositoryImpl(getIt()));
  getIt.registerLazySingleton<UpdateProfileImageRepository>(
      () => UpdateProfileImageRepositoryImpl(getIt()));
  getIt.registerLazySingleton<ManagerIdRepository>(
      () => ManageridRepositoryImpl(getIt()));

  // Usecases

  getIt
      .registerLazySingleton<LoginUserUsecase>(() => LoginUserUsecase(getIt()));
  getIt.registerLazySingleton<CreateGeneralRequestUsecase>(
      () => CreateGeneralRequestUsecase(getIt()));
  getIt.registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(getIt()));
  getIt.registerLazySingleton<ValidateOtpUsecase>(
      () => ValidateOtpUsecase(getIt()));
  getIt.registerLazySingleton<SendOtpUsecase>(() => SendOtpUsecase(getIt()));
  getIt
      .registerLazySingleton<ResendOtpUsecase>(() => ResendOtpUsecase(getIt()));
  getIt.registerLazySingleton<RequestUsecase>(() => RequestUsecase(getIt()));
  getIt.registerLazySingleton<UserInfoUsecase>(() => UserInfoUsecase(getIt()));
  getIt.registerLazySingleton<GetPackagesUsecase>(
      () => GetPackagesUsecase(getIt()));
  getIt.registerLazySingleton<GetPackageByPackageIdUsecase>(
      () => GetPackageByPackageIdUsecase(getIt()));
  getIt.registerLazySingleton<GetGiftsUsecase>(() => GetGiftsUsecase(getIt()));
  getIt
      .registerLazySingleton<GetOffersUsecase>(() => GetOffersUsecase(getIt()));
  getIt.registerLazySingleton<GetLoyaltyCardsUsecase>(
      () => GetLoyaltyCardsUsecase(getIt()));
  getIt.registerLazySingleton<GetAssignedLoyaltyCardsUsecase>(
      () => GetAssignedLoyaltyCardsUsecase(getIt()));
  getIt
      .registerLazySingleton<GetEventsUsecase>(() => GetEventsUsecase(getIt()));
  getIt.registerLazySingleton<GetTournamentsUsecase>(
      () => GetTournamentsUsecase(getIt()));
  getIt.registerLazySingleton<GetAirTicketsUsecase>(
      () => GetAirTicketsUsecase(getIt()));
  getIt.registerLazySingleton<GetAirportsUsecase>(
      () => GetAirportsUsecase(getIt()));
  getIt.registerLazySingleton<SendFeedbackUsecase>(
      () => SendFeedbackUsecase(getIt()));
  getIt.registerLazySingleton<StreamMessagesUseCase>(
      () => StreamMessagesUseCase(getIt()));
  getIt.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(getIt()));
  getIt.registerLazySingleton<FetchChatSummaryUseCase>(
      () => FetchChatSummaryUseCase(getIt()));
  getIt.registerLazySingleton<ForgotPasswordUsecase>(
      () => ForgotPasswordUsecase(getIt()));
  getIt.registerLazySingleton<VerifyMobileNumberUsecase>(
      () => VerifyMobileNumberUsecase(getIt()));
  getIt.registerLazySingleton<FileUploaderUsecase>(
      () => FileUploaderUsecase(getIt()));
  getIt.registerLazySingleton<FileDownloadUsecase>(
      () => FileDownloadUsecase(getIt()));
  getIt.registerLazySingleton<FCMTokenRegisterUsecase>(
      () => FCMTokenRegisterUsecase(getIt()));
  getIt
      .registerLazySingleton<GetHotelsUsecase>(() => GetHotelsUsecase(getIt()));
  getIt.registerLazySingleton<GetDepositsUsecase>(
      () => GetDepositsUsecase(getIt()));
  getIt.registerLazySingleton<GetWithdrawalUsecase>(
      () => GetWithdrawalUsecase(getIt()));
  getIt.registerLazySingleton<GetNotificationsUsecase>(
      () => GetNotificationsUsecase(getIt()));
  getIt.registerLazySingleton(() => GetNotificationsBySocketUseCase(
      repository: getIt<NotificationsRepository>()));
  getIt.registerLazySingleton<RedeemGiftUsecase>(
      () => RedeemGiftUsecase(getIt()));
  getIt.registerLazySingleton<UpdateProfileImageUsecase>(
      () => UpdateProfileImageUsecase(getIt()));
  getIt.registerLazySingleton<GetFeedbacktableUsecase>(
      () => GetFeedbacktableUsecase(getIt()));
  getIt.registerLazySingleton<GetManagerIdUsecase>(
      () => GetManagerIdUsecase(getIt()));

  print("Services registered successfully!");
}
