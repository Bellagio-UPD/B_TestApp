import 'package:bellagio_mobile_user/data/models/packages_model/packages_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';

part 'packages_service.g.dart';

@RestApi(baseUrl: urlTrnMgt)
abstract class PackagesService {
  factory PackagesService(Dio dio) = _PackagesService;

  @GET('/findall/package')
  Future<HttpResponse<List<PackagesModel>>> getAllPackages();

  @GET("/find/package")
  Future<HttpResponse<PackagesModel>> getPackageByPackageId({
    @Query("packageId") String? packageId
  });
}
