
part of 'fcm_cubit.dart';

abstract class FCMRegisterState extends Equatable {
  final FCMTokenRegisterModel? fcmModel;
  final DioException? error;

  const FCMRegisterState({this.fcmModel, this.error});

  @override
  List<Object?> get props => [fcmModel, error];
}

class FCMInitial extends FCMRegisterState {
  const FCMInitial({FCMTokenRegisterModel? fcmModel})
      : super(fcmModel: fcmModel);
}

class FCMLoadedState extends FCMRegisterState {
  const FCMLoadedState({FCMTokenRegisterModel? fcmModel})
      : super(fcmModel: fcmModel);
}

class FCMSuccessState extends FCMRegisterState {
  const FCMSuccessState({FCMTokenRegisterModel? fcmModel})
      : super(fcmModel: fcmModel);
}

class FCMErrorState extends FCMRegisterState {
  const FCMErrorState({FCMTokenRegisterModel? fcmModel, DioException? error})
      : super(fcmModel: fcmModel, error: error);
}
