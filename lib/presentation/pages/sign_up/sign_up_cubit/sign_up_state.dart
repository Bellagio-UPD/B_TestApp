part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  final SignUpModel? signUpModel;
  final DioException? error;

  const SignUpState({this.signUpModel, this.error});

  @override
  List<Object?> get props => [signUpModel, error];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial({SignUpModel? signupModel})
      : super(signUpModel: signupModel);
}

class SignUpLoadedState extends SignUpState {
  const SignUpLoadedState({SignUpModel? signupModel})
      : super(signUpModel: signupModel);
}

class SignUpSuccessState extends SignUpState {
  const SignUpSuccessState({SignUpModel? signupModel})
      : super(signUpModel: signupModel);
}

class SignUpErrorState extends SignUpState {
  const SignUpErrorState({SignUpModel? signupModel, DioException? error})
      : super(signUpModel: signupModel, error: error);
}
