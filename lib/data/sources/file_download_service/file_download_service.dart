import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';

part 'file_download_service.g.dart';

@RestApi(baseUrl: "")
abstract class FileDownloadService {
 factory FileDownloadService(Dio dio) = _FileDownloadService;

  @GET('{fileId}')
  @DioResponseType(ResponseType.bytes) // Ensures the response is treated as bytes
  Future<List<int>> downloadFile(@Path("fileId") String fileId);
}