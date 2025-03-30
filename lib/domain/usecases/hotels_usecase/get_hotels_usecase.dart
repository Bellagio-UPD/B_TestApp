import 'package:bellagio_mobile_user/data/models/hotels_model/hotels_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/hotels_repository/hotels_repository.dart';

import '../../../core/storage/data_state.dart';
import '../usecase/usecase.dart';

class GetHotelsUsecase implements UseCase<DataState<List<HotelsModel>>, void> {
  final HotelsRepository _hotelsRepository;

  GetHotelsUsecase(this._hotelsRepository);
  @override
  Future<DataState<List<HotelsModel>>> call({void params}) {
    return _hotelsRepository.getAllHotels();
  }
}