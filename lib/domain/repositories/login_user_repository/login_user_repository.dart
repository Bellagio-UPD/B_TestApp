import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/login_user_model.dart/login_user_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';

abstract class LoginUserRepository {
  Future<DataState<ResponseModel>> loginUser(LoginUserModel loginUserModel);
}
