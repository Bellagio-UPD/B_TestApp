import 'dart:io';

import 'package:bellagio_mobile_user/data/models/user_info_model/user_info_model.dart';
import 'package:bellagio_mobile_user/data/sources/user_info_service/user_info_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/user_info_repository/user-info_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';

class UserInfoRepositoryImpl implements GetUserInfoRepository {
  final UserInfoService _userInfoService;

  UserInfoRepositoryImpl(this._userInfoService);

  @override
  Future<DataState<UserInfoModel>> getUserInfoRepository() async {
    try {
      final sharedPrefManager = SharedPrefManager();
      final userId =
          await sharedPrefManager.getUserId(); // Resolve the Future here

      final httpResponse = await _userInfoService.getUserInfo(userId: userId);

      if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == HttpStatus.accepted) {
        // final email = httpResponse.response.data["Email"];
        // final mobileNumber = httpResponse.response.data["Phone"];
        // final managerId = httpResponse.response.data["ManagerId"];
        // final loyaltyProgramId = httpResponse.response.data["LoyaltyProgramId"];

        // await sharedPrefManager.saveEmail(email ?? '');
        // await sharedPrefManager.savePhoneNumber(mobileNumber ?? '');
        // await sharedPrefManager.saveManagerId(managerId ?? '');
        // await sharedPrefManager.saveLoyaltyProgramId(loyaltyProgramId ?? '');
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
