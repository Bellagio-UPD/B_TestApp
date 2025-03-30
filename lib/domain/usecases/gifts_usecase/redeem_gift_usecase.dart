import 'package:bellagio_mobile_user/data/models/qr_code_response_model/qr_code_return_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/gifts_repository/gifts_repository.dart';
import '../../../core/storage/data_state.dart';
import '../../../data/models/qr_code_response_model/qr_code_response_model.dart';

class RedeemGiftUsecase {
  final GiftsRepository giftsRepository;

  RedeemGiftUsecase(this.giftsRepository);

  Future<DataState<QrCodeResponseModel>> call(QrCodeReturnModel model) {
    return giftsRepository.redeemQRCode(model);
  }
}
