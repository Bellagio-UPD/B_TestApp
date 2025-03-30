import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model.dart';
import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model_new.dart';
import 'package:bellagio_mobile_user/data/models/qr_code_response_model/qr_code_response_model.dart';
import 'package:bellagio_mobile_user/data/models/qr_code_response_model/qr_code_return_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/data/sources/gifts_service/gifts_service.dart';
import 'package:bellagio_mobile_user/data/sources/redeem_qr_code_service/redeem_qr_code_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/gifts_repository/gifts_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/shared_pref_manager.dart';

class GiftsRepositoryImpl implements GiftsRepository {
  final GiftsService _giftsService;
  final RedeemQrCodeService _qrCodeService;
  GiftsRepositoryImpl(this._giftsService, this._qrCodeService);

  @override
  Future<DataState<List<GiftsModelNew>>> getGiftsRepository() async {
    final userId = await SharedPrefManager().getUserId();
    try {
      final httpResponse = await _giftsService.getGifts(customerId: userId);
      if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final giftList = (data as List)
            .map((e) => GiftsModelNew.fromJson(e as Map<String, dynamic>))
            .toList();
        return DataSuccess(giftList);
      } else {
        return DataFailed(DioException(
            type: DioExceptionType.badResponse,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<QrCodeResponseModel>> redeemQRCode(QrCodeReturnModel giftsModel) async {
    try {
      final httpResponse = await _qrCodeService.redeemQRCode(giftsModel);
      if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == HttpStatus.accepted) {
        final responseData = httpResponse.response.data;
        final qrCode = responseData['qr'];
        Uint8List bytes = base64Decode(qrCode);
        final qr = QrCodeResponseModel(qrCode: bytes);
        return DataSuccess(qr);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
