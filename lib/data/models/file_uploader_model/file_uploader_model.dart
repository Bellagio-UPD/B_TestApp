import 'package:dio/dio.dart';
import '../../../domain/entities/file_uploader_entity/file_uploader_entity.dart';

class UploadImageModel extends UploadImageEntity {
  const UploadImageModel({
    FormData? file,
  }):super(file: file);
}