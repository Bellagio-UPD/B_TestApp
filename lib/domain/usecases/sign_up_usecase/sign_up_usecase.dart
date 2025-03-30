import 'package:bellagio_mobile_user/data/models/sign_up_model/sign_up_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/sign_up_repository/sign_up_repository.dart';

import '../../../core/storage/data_state.dart';
import '../../../data/models/response_model/response_model.dart';

class SignUpUsecase {
  final SignUpRepository signUpRepository;

  SignUpUsecase(this.signUpRepository);

  Future<DataState<ResponseModel>> call(SignUpModel model) {
    return signUpRepository.signUpUser(model);
  }
}