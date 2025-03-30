import 'dart:io';

import 'package:bellagio_mobile_user/data/models/login_user_model.dart/login_user_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/data/sources/login_service/login_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/login_user_repository/login_user_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/dependency_injection/service_locator.dart';
import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../sources/location_service/location_service.dart';

class LoginUserRepositoryImpl implements LoginUserRepository {
  final LoginService _loginService;
  LoginUserRepositoryImpl(this._loginService);

  @override
  Future<DataState<ResponseModel>> loginUser(LoginUserModel loginModel) async {
    try {
      final httpResponse = await _loginService.loginUser(loginModel);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> responseData = httpResponse.response.data;
        
        final String userId = responseData['userId'];
        final String userName = responseData['customerName'];

        final sharedPrefManager = SharedPrefManager();
        await sharedPrefManager.saveUserId(userId);
        await sharedPrefManager.saveUserName(userName);
        final locationService = getIt<LocationService>();
        await locationService.sendLocation();

        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
