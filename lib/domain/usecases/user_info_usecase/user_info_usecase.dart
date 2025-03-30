import 'package:bellagio_mobile_user/data/models/user_info_model/user_info_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/user_info_repository/user-info_repository.dart';

import '../../../core/storage/data_state.dart';

class UserInfoUsecase {
  final GetUserInfoRepository getUserInfoRepository;

  UserInfoUsecase(this.getUserInfoRepository);

  Future<DataState<UserInfoModel>> call({void params}) {
    return getUserInfoRepository.getUserInfoRepository();
  }
}
