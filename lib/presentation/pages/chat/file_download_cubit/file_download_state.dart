import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class FileDownloadState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FileDownloadInitial extends FileDownloadState {}

class FileDownloadLoading extends FileDownloadState {}

class FileDownloadSuccess extends FileDownloadState {
  final File? file;

  FileDownloadSuccess(this.file);

  @override
  List<Object?> get props => [file];
}

class FileDownloadFailure extends FileDownloadState {
  final String error;

  FileDownloadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
