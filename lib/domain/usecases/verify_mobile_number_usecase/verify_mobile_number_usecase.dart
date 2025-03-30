import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/verify_mobile_number_repository/verify_mobile_number_repository.dart';

import '../../../core/storage/data_state.dart';
import '../usecase/usecase.dart';

class VerifyMobileNumberUsecase
    implements UseCase<DataState<ResponseModel>, String> {
  final VerifyMobileNumberRepository _verifyMobileNumberRepository;

  VerifyMobileNumberUsecase(this._verifyMobileNumberRepository);
  @override
  Future<DataState<ResponseModel>> call({String? params}) {
    return _verifyMobileNumberRepository.verifyMobileNumber(params??'');
  }
}
