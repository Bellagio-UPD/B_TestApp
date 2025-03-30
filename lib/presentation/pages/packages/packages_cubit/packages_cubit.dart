import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/domain/usecases/packages_usecase/get_package_by_package_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/packages_usecase/get_packages_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/packages_model/packages_model.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  final GetPackagesUsecase? getPackagesUsecase;
  final GetPackageByPackageIdUsecase? getPackageByPackageIdUsecase;

  PackagesCubit({this.getPackagesUsecase, this.getPackageByPackageIdUsecase})
      : super(PackagesInitialState());

  Future<void> getPackages() async {
    try {
      final loadPackages = await getPackagesUsecase!.call(params: null);
      if (loadPackages is DataSuccess || loadPackages.data != null) {
        emit(PackagesLoadedState(
            packagesList: loadPackages.data, error: loadPackages.error));
      } else {
        emit(PackagesErrorState(error: loadPackages.error));
      }
    } on DioException catch (e) {
      emit(PackagesErrorState(error: e));
    }
  }

  Future<void> getAssignedPackage() async {
    try {
      final assignedPackage =
          await getPackageByPackageIdUsecase!.call(params: null);
      if (assignedPackage is DataSuccess || assignedPackage.data != null) {
        emit(PackageLoadedState(
            package: assignedPackage.data, error: assignedPackage.error));
      } else {
        emit(PackageErrorState(error: assignedPackage.error));
      }
    } on DioException catch (e) {
      emit(PackageErrorState(error: e));
    }
  }
}
