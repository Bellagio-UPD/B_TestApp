import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/general_request_usecase/general_request_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/general_request_model/general_request_model.dart';

part 'general_request_state.dart';

class GeneralRequestCubit extends Cubit<GeneralRequestState> {
  final CreateGeneralRequestUsecase? createGeneralRequestUsecase;

  GeneralRequestCubit({this.createGeneralRequestUsecase})
      : super(const GeneralRequestInitial());

  Future<DataState<ResponseModel>> createGeneralRequest(
      GeneralRequestModel model) async {
    final result = await createGeneralRequestUsecase?.call(model);
    if (result is DataSuccess) {
      emit(GeneralRequestSuccessState(generalRequestModel: model));
      return DataSuccess(result!.data!);
    } else {
      emit(GeneralRequestErrorState(error: result!.error));
      return DataFailed(result.error ??
          DioException(
              requestOptions: result.error!.requestOptions,
              error: result.error));
    }
  }
}
