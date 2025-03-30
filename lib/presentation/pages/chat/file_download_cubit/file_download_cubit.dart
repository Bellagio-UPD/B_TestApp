import 'package:bellagio_mobile_user/domain/usecases/file_download_usecase/file_download_usecase.dart';
import 'package:bloc/bloc.dart';
import 'dart:io';
import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/domain/repositories/file_download_repository/file_download_repository.dart';

import 'file_download_state.dart';

class FileDownloadCubit extends Cubit<FileDownloadState> {
  final FileDownloadUsecase fileDownloadUsecase;

  FileDownloadCubit({required this.fileDownloadUsecase}) : super(FileDownloadInitial());

  Future<void> downloadFile(String fileId, String savePath) async {
    emit(FileDownloadLoading());

    try {
      final result = await fileDownloadUsecase.call(fileId, savePath);

      if (result is DataSuccess) {
        emit(FileDownloadSuccess(result.data));
      } else {
        emit(FileDownloadFailure(result.error.toString()));
      }
    } catch (e) {
      emit(FileDownloadFailure("Unexpected error: ${e.toString()}"));
    }
  }
}

