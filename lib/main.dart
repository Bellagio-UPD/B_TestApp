import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'core/dependency_injection/service_locator.dart';
import 'data/sources/location_service/location_service.dart';
import 'domain/usecases/firebase_chat_usecase/get_message_usecase.dart';
import 'domain/usecases/firebase_chat_usecase/send_message_usecase.dart';
import 'presentation/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('bellagio_user_bucket');
  await setupServiceLocator();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // iOS: Request permissions
  await _checkAndRequestPermissions();

  final locationService = getIt<LocationService>();
  await locationService.sendLocation();

  runApp(
    MultiProvider(
      providers: [
        Provider<StreamMessagesUseCase>(
          create: (_) => StreamMessagesUseCase(getIt.get()),
        ),
        Provider<SendMessageUseCase>(
          create: (_) => SendMessageUseCase(getIt.get()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> _checkAndRequestPermissions() async {
  // Check and request location permission
  PermissionStatus locationStatus = await Permission.location.status;
  if (!locationStatus.isGranted) {
    locationStatus = await Permission.location.request();
  }

  // Check and request notification permission (Android 13+ requires explicit request)
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (locationStatus.isPermanentlyDenied) {
    await openAppSettings();
  }

  print("Location Permission: ${locationStatus.isGranted}");
  print("Notification Permission: ${settings.authorizationStatus}");
}
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bellagio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "Montserrat",
      ),
      routerConfig: appRouter.goRouterConfig,
    );
  }
}
