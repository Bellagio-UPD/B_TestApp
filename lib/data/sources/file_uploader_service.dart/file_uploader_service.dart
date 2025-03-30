import 'dart:io';

import 'package:bellagio_mobile_user/data/models/file_uploader_model/file_uploader_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/urls.dart';
import '../../models/file_uploader_model/file_uploader_response_model.dart';

part 'file_uploader_service.g.dart';

@RestApi(baseUrl: urlFileMgt)
abstract class FileUploaderService {
  factory FileUploaderService(Dio dio) = _FileUploaderService;

//  @POST('/create/file')
//   Future<HttpResponse<UploadImageResponseModel>> uploadFile (
//     @Body() FormData uploadImageForm
  @POST('/create/file')
  @MultiPart()
  Future<HttpResponse<String>> uploadFile(
    @Part() String userId,
    @Part() String username,
    @Part(name: "file") File image,
  );
}
