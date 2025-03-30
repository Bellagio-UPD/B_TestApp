import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';

abstract class OtpRepository {
  Future<DataState<ResponseModel>> validateOtpRepository(
      String mobileNumber, int otp);
  Future<DataState<ResponseModel>> sendOtpRepository(
      String mobileNumber, String userId);
  Future<DataState<ResponseModel>> resendOtpRepository(String mobileNumber);
}
