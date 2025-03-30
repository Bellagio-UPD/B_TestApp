import 'dart:io';

import '../../../core/storage/data_state.dart';
import '../../entities/file_uploader_entity/file-uploader_response_entity.dart';
import '../../entities/file_uploader_entity/file_uploader_entity.dart';

abstract class FileUploaderRepository {
  Future<DataState<String>> uploadImage
      (String userId, String username, File image);
}
