import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class UploadImageEntity extends Equatable {
  final FormData? file;

  const UploadImageEntity({this.file});

  @override
  List<Object?> get props => [file];
}
