import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/data/models/sign_up_model/sign_up_model.dart';

abstract class SignUpRepository {
  Future<DataState<ResponseModel>> signUpUser(SignUpModel signUpModel);
}
