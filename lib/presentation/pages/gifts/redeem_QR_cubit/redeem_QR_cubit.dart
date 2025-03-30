import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model.dart';
import 'package:bellagio_mobile_user/data/models/qr_code_response_model/qr_code_return_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/gifts_usecase/redeem_gift_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/gifts_model/gifts_model_new.dart';
import '../../../../data/models/qr_code_response_model/qr_code_response_model.dart';

part 'redeem_QR_state.dart';

class RedeemQrCubit extends Cubit<RedeemQrState> {
  final RedeemGiftUsecase? redeemGiftUsecase;

  RedeemQrCubit({this.redeemGiftUsecase})
      : super(const RedeemQRInitialState());

  Future<DataState<QrCodeResponseModel>> redeemQR(
      QrCodeReturnModel model) async {
    final result = await redeemGiftUsecase?.call(model);
    // emit(RedeemQRInitialState());
    if (result is DataSuccess) {
      emit(RedeemQRSuccessState(model: model));
      return DataSuccess(result!.data!);
    } else {
      emit(RedeemQRErrorState(error: result!.error));
      return DataFailed(result.error ??
          DioException(
              requestOptions: result.error!.requestOptions,
              error: result.error));
    }
  }
}
