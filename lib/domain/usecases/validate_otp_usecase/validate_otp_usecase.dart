import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/otp_repository/otp_repository.dart';

class ValidateOtpUsecase {
  final OtpRepository otpRepository;

  ValidateOtpUsecase(this.otpRepository);

  Future<DataState<ResponseModel>> call(String mobileNumber, int otp) {
    return otpRepository.validateOtpRepository(mobileNumber, otp);
  }
}
