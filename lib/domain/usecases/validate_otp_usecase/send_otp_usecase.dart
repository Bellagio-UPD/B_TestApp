import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/otp_repository/otp_repository.dart';

import '../../../core/storage/data_state.dart';

class SendOtpUsecase {
  final OtpRepository otpRepository;

  SendOtpUsecase(this.otpRepository);

  Future<DataState<ResponseModel>> call(String mobileNumber, String userId) {
    return otpRepository.sendOtpRepository(mobileNumber, userId);
  }
}
