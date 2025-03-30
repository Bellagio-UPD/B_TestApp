import 'package:bellagio_mobile_user/data/models/airports_model/airports_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/airports_repository/airports_repository.dart';

import '../../../core/storage/data_state.dart';
import '../usecase/usecase.dart';

class GetAirportsUsecase implements UseCase<DataState<List<AirportModel>>, void> {
  final AirportsRepository _airportsRepository;

  GetAirportsUsecase(this._airportsRepository);
  @override
  Future<DataState<List<AirportModel>>> call({void params}) {
    return _airportsRepository.getAllAirports();
  }
}