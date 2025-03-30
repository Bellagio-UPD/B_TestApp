import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/general_request_usecase/general_request_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/request_usecase/request_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/general_request_model/general_request_model.dart';
import '../../../../data/models/request_model/request_model.dart';

part 'requests_state.dart';

class RequestCubit extends Cubit<RequestsState> {
  final RequestUsecase? requestUsecase;

  RequestCubit({this.requestUsecase})
      : super(const RequestsInitial());

  Future<DataState<ResponseModel>> createRequest(
      RequestModel model) async {
    final result = await requestUsecase?.call(model);
    if (result is DataSuccess) {
      emit(RequestSuccessState(model: model));
      return DataSuccess(result!.data!);
    } else {
      emit(RequestErrorState(error: result!.error));
      return DataFailed(result.error ??
          DioException(
              requestOptions: result.error!.requestOptions,
              error: result.error));
    }
  }
}
