part of 'user_info_cubit.dart';

abstract class UserInfoState extends Equatable {
  final UserInfoModel? userInfoModel;
  final DioException? error;

  const UserInfoState({this.userInfoModel, this.error});

  @override
  List<Object?> get props => [userInfoModel, error];
}

class UserInfoInitial extends UserInfoState {
  const UserInfoInitial({UserInfoModel? model})
      : super(userInfoModel: model);
}

class UserInfoSuccessState extends UserInfoState {
  const UserInfoSuccessState({UserInfoModel? model, DioException? error})
      : super(userInfoModel: model, error: error);
}

class UserInfoErrorState extends UserInfoState {
  const UserInfoErrorState({DioException? error})
      : super(error: error);
}