import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/tournaments_model/tournaments_model.dart';

abstract class TournamentsRepository {
  Future<DataState<List<TournamentsModel>>> getTournamentsRepository();
}