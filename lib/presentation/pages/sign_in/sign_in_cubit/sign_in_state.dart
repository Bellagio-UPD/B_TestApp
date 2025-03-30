part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  final LoginUserModel? loginUserModel;
  final DioException? error;

  const SignInState({this.loginUserModel, this.error});

  @override
  List<Object?> get props => [loginUserModel, error];
}

class SignInInitialState extends SignInState {
  const SignInInitialState([LoginUserModel? loginUserModel])
      : super(loginUserModel: loginUserModel);
}

class SignInLoadedState extends SignInState {
  const SignInLoadedState({LoginUserModel? loginUserModel})
      : super(loginUserModel: loginUserModel);
}

class SignInSuccessState extends SignInState {
  const SignInSuccessState({LoginUserModel? loginUserModel})
      : super(loginUserModel: loginUserModel);
}

class SignInErrorState extends SignInState {
  const SignInErrorState({LoginUserModel? loginUserModel, DioException? error})
      : super(loginUserModel: loginUserModel, error: error);
}
