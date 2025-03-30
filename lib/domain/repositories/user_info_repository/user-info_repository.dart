import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/user_info_model/user_info_model.dart';

abstract class GetUserInfoRepository {
  Future<DataState<UserInfoModel>> getUserInfoRepository();
}
