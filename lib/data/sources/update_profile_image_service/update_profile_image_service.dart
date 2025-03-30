import 'package:bellagio_mobile_user/core/constants/urls.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/data/models/user_info_model/user_info_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'update_profile_image_service.g.dart';

@RestApi(baseUrl: urlUsrMgt)
abstract class UpdateProfileImageService {
  factory UpdateProfileImageService(Dio dio) = _UpdateProfileImageService;

  @PATCH('/update/mobile/profileimage')
  Future<HttpResponse<UserInfoModel>> updateProfileImage(
      {@Query("customerId") String? userId,
      @Query("url") String? profileImage});
}
