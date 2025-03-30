import 'package:bellagio_mobile_user/data/models/air_tickets_model/air_tickets_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/air_tickets_repository/air_tickets_repository.dart';

import '../../../core/storage/data_state.dart';
import '../usecase/usecase.dart';

class GetAirTicketsUsecase implements UseCase<DataState<List<AirTicketModel>>, void> {
  final AirTicketsRepository _airTicketsRepository;

  GetAirTicketsUsecase(this._airTicketsRepository);
  @override
  Future<DataState<List<AirTicketModel>>> call({void params}) {
    return _airTicketsRepository.getAirTicketInfo();
  }
}
