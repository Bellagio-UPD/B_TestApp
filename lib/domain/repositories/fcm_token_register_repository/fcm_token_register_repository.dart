import '../../../core/storage/data_state.dart';
import '../../../data/models/fcm_token/fcm_token_model.dart';
import '../../../data/models/response_model/response_model.dart';

abstract class FCMRegisterRequestRepository {
  Future<DataState<ResponseModel>> fcmTokenRegistry(FCMTokenRegisterModel fcmTokenRegisterModel);
}
