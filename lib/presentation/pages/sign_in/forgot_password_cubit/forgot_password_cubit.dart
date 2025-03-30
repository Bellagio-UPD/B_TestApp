import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/forgot_password_usecase/forgot_password_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/request_usecase/request_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/forgot_password_model/forgot_password_model.dart';
import '../../../../data/models/request_model/request_model.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUsecase? forgotPasswordUsecase;

  ForgotPasswordCubit({this.forgotPasswordUsecase})
      : super(const ForgotPasswordInitial());

  Future<DataState<ResponseModel>> forgotPassword(
      ForgotPasswordModel model) async {
    final result = await forgotPasswordUsecase?.call(model);
    if (result is DataSuccess) {
      emit(ForgotPasswordSuccessState(model: model));
      return DataSuccess(result!.data!);
    } else {
      emit(ForgotPasswordErrorState(error: result!.error));
      return DataFailed(result.error ??
          DioException(
              requestOptions: result.error!.requestOptions,
              error: result.error));
    }
  }
}
