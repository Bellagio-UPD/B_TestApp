import 'package:bellagio_mobile_user/data/models/login_user_model.dart/login_user_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/login_user_repository/login_user_repository.dart';

import '../../../core/storage/data_state.dart';

class LoginUserUsecase {
  final LoginUserRepository loginUserRepository;

  LoginUserUsecase(this.loginUserRepository);

  Future<DataState<ResponseModel>> call(LoginUserModel model) {
    return loginUserRepository.loginUser(model);
  }
}
