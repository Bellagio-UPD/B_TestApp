import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/packages_model/packages_model.dart';

abstract class PackagesRepository {
  Future<DataState<List<PackagesModel>>> getPackagesRepository();
  Future<DataState<PackagesModel>> getPackageByPackageIdRepository();
}
