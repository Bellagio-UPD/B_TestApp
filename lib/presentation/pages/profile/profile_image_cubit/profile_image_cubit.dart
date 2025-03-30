import 'package:bellagio_mobile_user/data/models/response_model/response_model.dart';
import 'package:bellagio_mobile_user/data/models/user_info_model/user_info_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/update_profile_image_usecase/update_profile_image.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/data_state.dart';
import '../../requests/requests_cubit/requests_cubit.dart';

part 'profile_image_state.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  final UpdateProfileImageUsecase? updateProfileImageUsecase;

  ProfileImageCubit({this.updateProfileImageUsecase})
      : super(const ProfileImageInitialState());

  Future<DataState<UserInfoModel>> createRequest(
      String imageUrl) async {
    final result = await updateProfileImageUsecase?.call(imageUrl);
    if (result is DataSuccess) {
      emit(ProfileImageSuccessState(url: imageUrl));
      return DataSuccess(result!.data ?? UserInfoModel());
    } else {
      emit(ProfileImageErrorState(error: result!.error));
      return DataFailed(result.error ??
          DioException(
              requestOptions: result.error!.requestOptions,
              error: result.error));
    }
  }
}
