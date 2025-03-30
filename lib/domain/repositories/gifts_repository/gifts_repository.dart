import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model_new.dart';
import 'package:bellagio_mobile_user/data/models/qr_code_response_model/qr_code_return_model.dart';
import '../../../core/storage/data_state.dart';
import '../../../data/models/qr_code_response_model/qr_code_response_model.dart';

abstract class GiftsRepository {
  Future<DataState<List<GiftsModelNew>>> getGiftsRepository();
  Future<DataState<QrCodeResponseModel>> redeemQRCode(QrCodeReturnModel giftsModel);
}
