import 'package:bellagio_mobile_user/data/models/tournaments_model/tournaments_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/tournaments_repository/tournaments_repository.dart';

import '../../../core/storage/data_state.dart';
import '../usecase/usecase.dart';

class GetTournamentsUsecase
    implements UseCase<DataState<List<TournamentsModel>>, void> {
  final TournamentsRepository _tournamentsRepository;
  GetTournamentsUsecase(this._tournamentsRepository);
  @override
  Future<DataState<List<TournamentsModel>>> call({void params}) {
    return _tournamentsRepository.getTournamentsRepository();
  }
}
