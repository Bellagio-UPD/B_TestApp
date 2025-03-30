part of 'redeem_QR_cubit.dart';

abstract class RedeemQrState extends Equatable {
  final QrCodeReturnModel? giftsModel;
  final DioException? error;

  const RedeemQrState({this.giftsModel, this.error});

  @override
  List<Object?> get props => [giftsModel, error];
}

class RedeemQRInitialState extends RedeemQrState {
  const RedeemQRInitialState({QrCodeReturnModel? model})
      : super(giftsModel: model);
}

class RedeemQRSuccessState extends RedeemQrState {
  const RedeemQRSuccessState({QrCodeReturnModel? model})
      : super(giftsModel: model);
}

class RedeemQRErrorState extends RedeemQrState {
  const RedeemQRErrorState({QrCodeReturnModel? model, DioException? error})
      : super(giftsModel: model, error: error);
}
