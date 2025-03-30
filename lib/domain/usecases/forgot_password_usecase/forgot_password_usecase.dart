import 'package:bellagio_mobile_user/data/models/forgot_password_model/forgot_password_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/forgot_password_repository/forgot_password_repository.dart';
import '../../../core/storage/data_state.dart';
import '../../../data/models/response_model/response_model.dart';

class ForgotPasswordUsecase {
  final ForgotPasswordRepository forgotPasswordRepository;

  ForgotPasswordUsecase(this.forgotPasswordRepository);

  Future<DataState<ResponseModel>> call(ForgotPasswordModel forgotPasswordModel) {
    return forgotPasswordRepository.forgotPasswordRepository(forgotPasswordModel);
  }
}