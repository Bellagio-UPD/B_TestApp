part of 'verify_mobile_cubit.dart';

abstract class VerifyMobileState extends Equatable {
  final ResponseModel? mobileNumber;
  final DioException? error;

  VerifyMobileState({this.mobileNumber, this.error});

  @override
  List<Object?> get props => [mobileNumber, error];
}

class VerifyMobileInitialState extends VerifyMobileState {
  VerifyMobileInitialState({ResponseModel? mobileNumber, DioException? error})
      : super(mobileNumber: mobileNumber, error: error);
}

class VerifyMobileLoadedState extends VerifyMobileState {
  VerifyMobileLoadedState({ResponseModel? mobileNumber, DioException? error})
      : super(mobileNumber: mobileNumber, error: error);
}

class VerifyMobileErrorState extends VerifyMobileState {
  VerifyMobileErrorState({DioException? error}) : super(error: error);
}
