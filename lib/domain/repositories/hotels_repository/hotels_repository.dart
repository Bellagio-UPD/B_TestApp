import 'package:bellagio_mobile_user/data/models/hotels_model/hotels_model.dart';

import '../../../core/storage/data_state.dart';

abstract class HotelsRepository {
  Future<DataState<List<HotelsModel>>>getAllHotels();
}