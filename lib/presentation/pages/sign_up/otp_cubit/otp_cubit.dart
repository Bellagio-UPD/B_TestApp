import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/resend_otp_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/send_otp_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/validate_otp_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/response_model/response_model.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final ValidateOtpUsecase? validateOtpUsecase;
  final SendOtpUsecase? sendOtpUsecase;
  final ResendOtpUsecase? resendOtpUsecase;

  OtpCubit({this.sendOtpUsecase, this.validateOtpUsecase , this.resendOtpUsecase})
      : super(validateOtpState());

  Future<DataState<ResponseModel>> validateOtp(
      String mobileNumber, int otp) async {
    final result = await validateOtpUsecase?.call(mobileNumber, otp);
    if (result is DataSuccess) {
      emit(validateOtpState(mobileNumber: mobileNumber, otp: otp));
      return DataSuccess(result!.data!);
    } else {
      emit(validateOtpErrorState(error: result!.error));
      return DataFailed(result.error ??
          DioException(
              requestOptions: result.error!.requestOptions,
              error: result.error));
    }
  }

  Future<DataState<ResponseModel>> sendOtp(
      String userId, String mobileNumber) async {
    final result = await sendOtpUsecase?.call(mobileNumber, userId);
    if (result is DataSuccess) {
      emit(sendOtpState(mobileNumber: mobileNumber, userId: userId));
      return DataSuccess(result!.data!);
    } else {
      emit(sendOtpErrorState(error: result!.error!));
      return DataFailed(result.error ??
          DioException(
              requestOptions: result.error!.requestOptions,
              error: result.error));
    }
  }

  Future<DataState<ResponseModel>> resendOtp(
        String mobileNumber) async {
    final result = await resendOtpUsecase?.call(mobileNumber);
    if (result is DataSuccess) {
      emit(resendOtpState(mobileNumber: mobileNumber));
      return DataSuccess(result!.data!);
    } else {
      emit(resendOtpErrorState(error: result!.error!));
      return DataFailed(result.error ??
          DioException(
              requestOptions: result.error!.requestOptions,
              error: result.error));
    }
  }
}
