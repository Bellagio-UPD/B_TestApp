import 'package:bellagio_mobile_user/data/models/user_info_model/user_info_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/update_profile_image_repository/update_profile_image_repository.dart';
import '../../../core/storage/data_state.dart';

class UpdateProfileImageUsecase {
  final UpdateProfileImageRepository updateProfileImageRepository;

  UpdateProfileImageUsecase(this.updateProfileImageRepository);

  Future<DataState<UserInfoModel>> call(String url) {
    return updateProfileImageRepository.updateProfileImg(url);
  }
}
