import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model_new.dart';
import 'package:bellagio_mobile_user/domain/repositories/gifts_repository/gifts_repository.dart';
import 'package:bellagio_mobile_user/domain/usecases/usecase/usecase.dart';

class GetGiftsUsecase implements UseCase<DataState<List<GiftsModelNew>>, void> {
  final GiftsRepository _giftsRepository;

  GetGiftsUsecase(this._giftsRepository);
  @override
  Future<DataState<List<GiftsModelNew>>> call({void params}) {
    return _giftsRepository.getGiftsRepository();
  }
}
