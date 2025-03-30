import 'dart:typed_data';

import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model.dart';
import 'package:bellagio_mobile_user/data/models/qr_code_response_model/qr_code_return_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/gifts_model/gifts_model_new.dart';
import '../../models/response_model/response_model.dart';

part 'redeem_qr_code_service.g.dart';

@RestApi(baseUrl: urlCstmReqMgt)
abstract class RedeemQrCodeService {
  factory RedeemQrCodeService(Dio dio) = _RedeemQrCodeService;

  @POST('/RedeemGift')
  Future<HttpResponse<ResponseModel>> redeemQRCode(
      @Body() QrCodeReturnModel giftsModel);
}
