import 'package:bellagio_mobile_user/data/models/airports_model/airports_model.dart';

import '../../../core/storage/data_state.dart';

abstract class AirportsRepository {
  Future<DataState<List<AirportModel>>>getAllAirports();
}