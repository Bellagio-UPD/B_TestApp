import 'dart:async';

import 'package:bellagio_mobile_user/core/storage/shared_pref_manager.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/routes/routes.dart';

class TokenInterceptor extends Interceptor {
  final SharedPrefManager sharedPrefManager;
  // final BuildContext context;

  TokenInterceptor({required this.sharedPrefManager});

  // void logOut() async {
  //   await sharedPrefManager.clearAll();
  //   await sharedPrefManager.clearManagerId();
  //   await FirebaseAuth.instance.signOut();
  //   // GoRouter.of(context).goNamed(Routes.signIn);
  //   // Navigator.popAndPushNamed(context, routeName)
  // }
  
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await sharedPrefManager.getToken();

    if (accessToken == null || await isTokenExpired()) {
      accessToken = await refreshToken();
    }

    if (accessToken != null) {
      options.headers['Authorization-Firebase'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  Future<bool> isTokenExpired() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return true;

    IdTokenResult tokenResult = await user.getIdTokenResult();
    DateTime expiryDate = tokenResult.expirationTime ?? DateTime.now();

    return expiryDate.isBefore(DateTime.now().add(Duration(minutes: 10)));
  }

  Future<String?> refreshToken() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? newToken = await user.getIdToken(true);
        await sharedPrefManager.saveToken(newToken!);
        return newToken;
      }
    } catch (e) {
      print("Token refresh failed: $e");
    }
    return null;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String? newToken = await refreshToken();

      if (newToken != null) {
        err.requestOptions.headers['Authorization-Firebase'] = 'Bearer $newToken';
        try {
          Response response = await Dio().fetch(err.requestOptions);
          handler.resolve(response);
          return;
        } catch (e) {
          print("Retry request failed: $e");
        }
      }

    }

    super.onError(err,handler);
    }

}