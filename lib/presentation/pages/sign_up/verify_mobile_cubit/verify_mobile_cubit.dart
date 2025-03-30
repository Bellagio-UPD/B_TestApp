import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/verify_mobile_number_usecase/verify_mobile_number_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_mobile_state.dart';

class VerifyMobileCubit extends Cubit<VerifyMobileState> {
  final VerifyMobileNumberUsecase? verifyMobileNumberUsecase;

  VerifyMobileCubit({this.verifyMobileNumberUsecase})
      : super(VerifyMobileInitialState());

  Future<DataState<ResponseModel>> verifyMobile(String mobileNumber) async {
    final verifyMobile =
        await verifyMobileNumberUsecase!.call(params: mobileNumber);
    if (verifyMobile is DataSuccess) {
      emit(VerifyMobileLoadedState(
          mobileNumber: verifyMobile.data, error: verifyMobile.error));
      return DataSuccess(verifyMobile.data!);
    } else {
      emit(VerifyMobileInitialState(error: verifyMobile.error));
      return DataFailed(verifyMobile.error ??
          DioException(
              requestOptions: verifyMobile.error!.requestOptions,
              error: verifyMobile.error));
    }

    // return ;
  }
}
