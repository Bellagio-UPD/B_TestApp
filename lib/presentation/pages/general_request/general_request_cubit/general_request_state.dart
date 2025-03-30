part of 'general_request_cubit.dart';

abstract class GeneralRequestState extends Equatable {
  final GeneralRequestModel? requestModel;
  final DioException? error;

  const GeneralRequestState({this.requestModel, this.error});

  @override
  List<Object?> get props => [requestModel, error];
}

class GeneralRequestInitial extends GeneralRequestState {
  const GeneralRequestInitial({GeneralRequestModel? generalRequestModel})
      : super(requestModel: generalRequestModel);
}

class GeneralRequestSuccessState extends GeneralRequestState {
  const GeneralRequestSuccessState({GeneralRequestModel? generalRequestModel})
      : super(requestModel: generalRequestModel);
}

class GeneralRequestErrorState extends GeneralRequestState {
  const GeneralRequestErrorState({GeneralRequestModel? generalRequestModel, DioException? error})
      : super(requestModel: generalRequestModel, error: error);
}
