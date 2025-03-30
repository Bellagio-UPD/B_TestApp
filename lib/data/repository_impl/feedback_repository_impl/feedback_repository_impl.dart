import 'dart:io';

import 'package:bellagio_mobile_user/data/models/feedback_model/feedback_model.dart';
import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/data/sources/feedback_service/feedback_service.dart';
import 'package:bellagio_mobile_user/data/sources/feedback_service/feedback_table_service.dart';
import 'package:bellagio_mobile_user/domain/repositories/feedback_repository/feedback_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/storage/data_state.dart';
import '../../models/feedback_model/feedback_table_model.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackService _feedbackService;
  final FeedbackTableService _feedbackTableService;
  FeedbackRepositoryImpl(this._feedbackService, this._feedbackTableService);

  @override
  Future<DataState<ResponseModel>> sendFeedback(FeedbackModel model) async {
    try {
      final httpResponse = await _feedbackService.createFeedback(model);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<FeedbackTableModel>>> getFeedbackDropdownLists() async {
    try {
      final httpResponse = await _feedbackTableService.getGamesNTables();
   if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == HttpStatus.accepted) {
        final data = httpResponse.response.data;
        final giftList = (data as List)
            .map((e) => FeedbackTableModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return DataSuccess(giftList);
      } else {
        return DataFailed(DioException(
            type: DioExceptionType.badResponse,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
