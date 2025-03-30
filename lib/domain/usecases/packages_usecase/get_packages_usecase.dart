import 'package:bellagio_mobile_user/data/models/packages_model/packages_model.dart';
import 'package:bellagio_mobile_user/domain/repositories/packages_repository/packages_repository.dart';

import '../../../core/storage/data_state.dart';
import '../usecase/usecase.dart';

class GetPackagesUsecase
    implements UseCase<DataState<List<PackagesModel>>, void> {
  final PackagesRepository _packagesRepository;
  GetPackagesUsecase(this._packagesRepository);
  @override
  Future<DataState<List<PackagesModel>>> call({void params}) {
    return _packagesRepository.getPackagesRepository();
  }
}
