import 'package:bellagio_mobile_user/domain/usecases/login_user_usecase.dart/login_user_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/login_user_model.dart/login_user_model.dart';
import '../../../../data/models/response_model/response_model.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final LoginUserUsecase? loginUserUsecase;
  SignInCubit({this.loginUserUsecase}) : super(const SignInInitialState());

  Future<DataState<ResponseModel>> loginUser(LoginUserModel loginModel) async {
    final result = await loginUserUsecase?.call(loginModel);
    try {
      if (result is DataSuccess) {
        emit(SignInSuccessState(loginUserModel: loginModel));
        return DataSuccess(result!.data!);
      } else {
        emit(SignInErrorState(error: result!.error));
        return DataFailed(result.error ??
            DioException(
                requestOptions: result.error!.requestOptions,
                error: result.error));
      }
    } on DioException catch (error) {
      return DataFailed(error);
    }
  }
}
