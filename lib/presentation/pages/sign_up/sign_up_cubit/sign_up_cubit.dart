import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/sign_up_usecase/sign_up_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/sign_up_model/sign_up_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUsecase? signUpUsecase;

  SignUpCubit({this.signUpUsecase}) : super(const SignUpInitial());

  Future<DataState<ResponseModel>> createUser(SignUpModel signupModel) async {
    final result = await signUpUsecase?.call(signupModel);
    try {
      if (result is DataSuccess) {
        emit(SignUpSuccessState(signupModel: signupModel));
        return DataSuccess(result!.data!);
      } else {
        emit(SignUpErrorState(error: result!.error));
        return DataFailed(result.error ??
            DioException(
              response: result.error!.response!.data,
                requestOptions: result.error!.requestOptions,
                error: result.error));
      }
    } on DioException catch (error) {
      return DataFailed(error.response!.data);
    }
  }

  void updateFields(SignUpModel model) {
    emit(SignUpLoadedState(signupModel: model));
  }
}
