import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/fcm_token/fcm_token_model.dart';
import '../../../../data/models/response_model/response_model.dart';
import '../../../../domain/usecases/fcm_register_usecase/fcm_token_register_usecase.dart';

part 'fcm_state.dart';

class FCMCubit extends Cubit<FCMRegisterState> {
  final FCMTokenRegisterUsecase? fcmTokenRegisterUsecase;

  FCMCubit({this.fcmTokenRegisterUsecase})
      : super(FCMInitial());


  Future<DataState<ResponseModel>> fcmTokenRegister(
      String token, String userID) async {
    final fcmModel = FCMTokenRegisterModel(
      Token: token,
      CustomerID: userID,

    );    final result = await fcmTokenRegisterUsecase?.call(fcmModel);
    if (result is DataSuccess) {
      emit(FCMSuccessState(fcmModel: fcmModel));
      return DataSuccess(result!.data!);
    } else {
      emit(FCMErrorState(error: result!.error));
      return DataFailed(result.error ??
          DioException(
              requestOptions: result.error!.requestOptions,
              error: result.error));
    }
  }
}