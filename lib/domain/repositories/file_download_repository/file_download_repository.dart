import 'dart:io';
import '../../../core/storage/data_state.dart';

abstract class FileDownloadRepository {
  Future<DataState<File>> downloadFile(String fileId, String savePath);
}

