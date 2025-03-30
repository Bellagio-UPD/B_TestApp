import 'package:bellagio_mobile_user/data/models/user_info_model/user_info_model.dart';

import '../../../core/storage/data_state.dart';

abstract class UpdateProfileImageRepository {
  Future<DataState<UserInfoModel>> updateProfileImg(String imgUrl);
}