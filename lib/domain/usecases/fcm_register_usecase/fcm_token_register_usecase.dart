import 'package:bellagio_mobile_user/data/models/fcm_token/fcm_token_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/fcm_token_register_repository/fcm_token_register_repository.dart';

import '../../../core/storage/data_state.dart';
import '../../../data/models/response_model/response_model.dart';

class FCMTokenRegisterUsecase {
  final FCMRegisterRequestRepository fcmRepository;

  FCMTokenRegisterUsecase(this.fcmRepository);

  Future<DataState<ResponseModel>> call(FCMTokenRegisterModel fcmModel) {
    return fcmRepository.fcmTokenRegistry(fcmModel);
  }
}
