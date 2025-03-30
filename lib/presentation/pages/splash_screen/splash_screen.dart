import 'package:bellagio_mobile_user/presentation/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/color_manager.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/style_manager.dart';
import '../../routes/routes.dart';

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkForUpdates();
  }

  Future<void> checkForUpdates() async {
    Map<String, dynamic>? appData = await fetchAppDataFromFirebase();
    if (appData == null) {
      proceedWithAuthCheck();
      return;
    }

    String? latestBuildNumberStr = appData['build'];
    bool isMajorUpdate = appData['isMajor'] ?? false;
    print(latestBuildNumberStr);
    print(isMajorUpdate);

    if (latestBuildNumberStr == null) {
      proceedWithAuthCheck();
      return;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int currentBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
    int latestBuildNumber = int.tryParse(latestBuildNumberStr) ?? 0;


    if (latestBuildNumber > currentBuildNumber) {
      showUpdateDialog(isMajorUpdate);
    } else {
      proceedWithAuthCheck();
    }
  }

  Future<Map<String, dynamic>?> fetchAppDataFromFirebase() async {
    try {
      DatabaseReference dbRef = FirebaseDatabase.instance.ref();

      // Fetch both app_version and isMajor
      DataSnapshot snapshot = (await dbRef.once()).snapshot;
      if (snapshot.value is Map) {
        Map<dynamic, dynamic> data = snapshot.value as Map;
        return {
          'build': data['build']?.toString(),
          'isMajor': data['isMajor'] ?? false,
        };
      }
    } catch (e) {
      debugPrint("Error fetching app data: $e");
    }
    return null;
  }

  void showUpdateDialog(bool isMajor) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
         backgroundColor: AppColors.purple2,
        title:  Text("Update Available",style: getContentTextLarge()),
        content: Text(
            isMajor
                ? "A critical update is required. Please update to continue using the app."
                : "A new version is available. Would you like to update now?",
         style: getButtonLabelMedium(),),
        actions: [
          if (!isMajor)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                proceedWithAuthCheck();
              },
              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.tileColor)),
              child: Text("Skip", style: getContentTextSmall()),
            ),
          TextButton(
            onPressed: () async {
              final String url;
              if (Platform.isAndroid) {
                url = "https://play.google.com/store/apps/details?id=com.bellagio.loyalty";
              } else if (Platform.isIOS) {
                //ToDo add ios version
                url = "Todo";
              } else {
                url = "";
              }
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              }
              if (isMajor) exit(0); // Force close app if major update is required
            },
              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.secondaryColor)),
            child:  Text("Update", style: getLabelTextMedium()),
          ),
        ],
      ),
    );
  }

  void proceedWithAuthCheck() async {
    Future.delayed(const Duration(seconds: 3), () async {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        try {
          await currentUser.reload();
          currentUser = FirebaseAuth.instance.currentUser;

          if (currentUser != null) {
            GoRouter.of(context).goNamed(Routes.navDashboard);
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-disabled') {
            FirebaseAuth.instance.signOut();
          }
          GoRouter.of(context).goNamed(Routes.signIn);
        }
      } else {
        GoRouter.of(context).goNamed(Routes.signIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: const Image(image: AssetImage("assets/images/logo.png")),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
