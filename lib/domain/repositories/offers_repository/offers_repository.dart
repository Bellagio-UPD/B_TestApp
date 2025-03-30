import 'package:bellagio_mobile_user/data/models/offers_model/offers_model.dart';

import '../../../core/storage/data_state.dart';

abstract class OffersRepository {
  Future<DataState<List<OffersModel>>>getOffersRepository();
}