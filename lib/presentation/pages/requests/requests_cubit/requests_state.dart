part of 'requests_cubit.dart';

abstract class RequestsState extends Equatable {
  final RequestModel? requestModel;
  final DioException? error;

  const RequestsState({this.requestModel, this.error});

  @override
  List<Object?> get props => [requestModel, error];
}

class RequestsInitial extends RequestsState {
  const RequestsInitial({RequestModel? model})
      : super(requestModel: model);
}

class RequestSuccessState extends RequestsState {
  const RequestSuccessState({RequestModel? model})
      : super(requestModel: model);
}

class RequestErrorState extends RequestsState {
  const RequestErrorState({RequestModel? model, DioException? error})
      : super(requestModel: model, error: error);
}
