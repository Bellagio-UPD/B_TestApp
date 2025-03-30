import 'dart:io';
import 'package:bellagio_mobile_user/domain/repositories/file_uploader_repository/file_uploader_repository.dart';
import '../../../core/storage/data_state.dart';


class FileUploaderUsecase {
  final FileUploaderRepository fileUploaderRepository;

  FileUploaderUsecase(this.fileUploaderRepository);

  Future<DataState<String>> call(String userId, String username, File image) {
    return fileUploaderRepository.uploadImage(userId, username, image);
  }
}
