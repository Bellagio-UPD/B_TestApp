import 'package:bellagio_mobile_user/data/models/air_tickets_model/air_tickets_model.dart';

import '../../../core/storage/data_state.dart';

abstract class AirTicketsRepository {
  Future<DataState<List<AirTicketModel>>>getAirTicketInfo();
}