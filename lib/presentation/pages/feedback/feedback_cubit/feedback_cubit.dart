import 'package:bellagio_mobile_user/data/models/feedback_model/feedback_table_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/feedback_usecase/get_feedbackTable_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/feedback_usecase/send_feedback_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/feedback_model/feedback_model.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbacksState> {
  final SendFeedbackUsecase? sendFeedbackUsecase;
  final GetFeedbacktableUsecase? getFeedbacktableUsecase;

  FeedbackCubit({this.sendFeedbackUsecase, this.getFeedbacktableUsecase})
      : super(const FeedbacksInitial());

  Future<DataState<ResponseModel>> createFeedback(FeedbackModel model) async {
    final result = await sendFeedbackUsecase!.call(model);
    if (result is DataSuccess) {
      emit(FeedbackSuccessState(model: model));
      return DataSuccess(result.data!);
    } else {
      emit(FeedbackErrorState(error: result.error));
      return DataFailed(result.error ??
          DioException(
              requestOptions: result.error!.requestOptions,
              error: result.error));
    }
  }

  Future<void> getTableNGames() async {
    try {
      final result = await getFeedbacktableUsecase!.call(params: null);
      if (result is DataSuccess) {
        emit(FeedbackTableSuccessState(
            feedbackModel: result.data, error: result.error));
      } else {
        emit(FeedbackTableErrorState(
            feedbackModel: result.data, error: result.error));
      }
    } on DioException catch (e) {
      emit(FeedbackTableErrorState(error: e));
    }
  }
}
