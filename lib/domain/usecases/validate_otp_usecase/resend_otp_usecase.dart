import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/otp_repository/otp_repository.dart';
import '../../../core/storage/data_state.dart';

class ResendOtpUsecase {
  final OtpRepository otpRepository;

  ResendOtpUsecase(this.otpRepository);

  Future<DataState<ResponseModel>> call(String mobileNumber) {
    return otpRepository.resendOtpRepository(mobileNumber);
  }
}