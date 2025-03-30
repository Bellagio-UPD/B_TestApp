import 'dart:io';

import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/sources/file_download_service/file_download_service.dart';
import 'package:dio/dio.dart';

import '../../../domain/repositories/file_download_repository/file_download_repository.dart';

class FileDownloadRepositoryImpl implements FileDownloadRepository {
  final FileDownloadService fileDownloadService;

  FileDownloadRepositoryImpl(this.fileDownloadService);

  @override
  Future<DataState<File>> downloadFile(String fileId, String savePath) async {
    try {
      final bytes = await fileDownloadService.downloadFile(fileId);

      File file = File(savePath);
      await file.writeAsBytes(bytes);

      return DataSuccess(file);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
