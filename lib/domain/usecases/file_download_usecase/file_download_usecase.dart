import 'dart:io';
import 'package:bellagio_mobile_user/domain/repositories/file_download_repository/file_download_repository.dart';
import '../../../core/storage/data_state.dart';

class FileDownloadUsecase {
  final FileDownloadRepository fileDownloadRepository;

  FileDownloadUsecase(this.fileDownloadRepository);

  Future<DataState<File>> call(String fileId, String savePath) {
    return fileDownloadRepository.downloadFile(fileId, savePath);
  }
}
