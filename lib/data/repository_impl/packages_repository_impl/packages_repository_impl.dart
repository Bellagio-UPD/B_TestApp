import 'dart:io';

import 'package:bellagio_mobile_user/data/models/packages_model/packages_model.dart';
import 'package:bellagio_mobile_user/data/sources/packages_service.dart/packages_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/packages_repository/packages_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';

class PackagesRepositoryImpl implements PackagesRepository {
  final PackagesService _packagesService;
  PackagesRepositoryImpl(this._packagesService);

  final sharedPrefManager = SharedPrefManager();

  @override
  Future<DataState<List<PackagesModel>>> getPackagesRepository() async {
    try {
      final httpResponse = await _packagesService.getAllPackages();
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final packagesList = (data as List)
            .map((e) => PackagesModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return DataSuccess(packagesList);
      } else {
        return DataFailed(DioException(
            type: DioExceptionType.badResponse,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<PackagesModel>> getPackageByPackageIdRepository() async {
    final packageId = await sharedPrefManager.getPackageId();
    try {
      final httpResponse =
          await _packagesService.getPackageByPackageId(packageId: packageId);
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        // final package = (data as List)
        //     .map((e) => PackagesModel.fromJson(e as Map<String, dynamic>))
        //     .toList();
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            type: DioExceptionType.badResponse,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
