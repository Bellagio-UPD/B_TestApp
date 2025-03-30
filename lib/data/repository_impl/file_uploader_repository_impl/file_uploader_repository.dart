import 'dart:io';

import 'package:bellagio_mobile_user/data/sources/file_uploader_service.dart/file_uploader_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/file_uploader_repository/file_uploader_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';

class UploadProfileImageImpl implements FileUploaderRepository {
  final FileUploaderService uploadImageService;
  UploadProfileImageImpl(this.uploadImageService);

  @override
  Future<DataState<String>> uploadImage(
      String userId, String username, File image) async {
    print("${userId}, ${username}, ${image}");
    try {
      final httpResponse =
          await uploadImageService.uploadFile(userId, username, image);

      if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == HttpStatus.accepted) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
              type: DioExceptionType.badResponse,
              response: httpResponse.response,
              requestOptions: RequestOptions(path: ''),
              error: httpResponse.toString()),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
