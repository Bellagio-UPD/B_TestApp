import 'dart:io';

import 'package:bellagio_mobile_user/data/models/user_info_model/user_info_model.dart';
import 'package:bellagio_mobile_user/data/sources/update_profile_image_service/update_profile_image_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/update_profile_image_repository/update_profile_image_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../models/request_model/request_model.dart';

class UpdateProfileImageRepositoryImpl implements UpdateProfileImageRepository {
  final UpdateProfileImageService _updateProfileImageService;
  UpdateProfileImageRepositoryImpl(this._updateProfileImageService);

  @override
  Future<DataState<UserInfoModel>> updateProfileImg(String url) async {
    try {
      final sharedPrefManager = SharedPrefManager();
      final userId =
          await sharedPrefManager.getUserId();
      final httpResponse = await _updateProfileImageService.updateProfileImage(
          userId: userId, profileImage: url);
      if (httpResponse.response.statusCode == HttpStatus.ok || httpResponse.response.statusCode == HttpStatus.accepted) {
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
