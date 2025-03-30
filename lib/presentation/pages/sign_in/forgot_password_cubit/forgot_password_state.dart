part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  final ForgotPasswordModel? forgotPasswordModel;
  final DioException? error;

  const ForgotPasswordState({this.forgotPasswordModel, this.error});

  @override
  List<Object?> get props => [forgotPasswordModel, error];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial({ForgotPasswordModel? model})
      : super(forgotPasswordModel: model);
}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  const ForgotPasswordSuccessState({ForgotPasswordModel? model})
      : super(forgotPasswordModel: model);
}

class ForgotPasswordErrorState extends ForgotPasswordState {
  const ForgotPasswordErrorState({ForgotPasswordModel? model, DioException? error})
      : super(forgotPasswordModel: model, error: error);
}
