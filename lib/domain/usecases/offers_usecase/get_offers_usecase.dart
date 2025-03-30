import 'package:bellagio_mobile_user/domain/repositories/offers_repository/offers_repository.dart';
import 'package:bellagio_mobile_user/domain/usecases/usecase/usecase.dart';

import '../../../core/storage/data_state.dart';
import '../../../data/models/offers_model/offers_model.dart';

class GetOffersUsecase implements UseCase<DataState<List<OffersModel>>, void> {
  final OffersRepository _offersRepository;

  GetOffersUsecase(this._offersRepository);
  @override
  Future<DataState<List<OffersModel>>> call({void params}) {
    return _offersRepository.getOffersRepository();
  }
}
