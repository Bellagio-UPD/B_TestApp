part of 'profile_image_cubit.dart';

abstract class ProfileImageState extends Equatable {
  final String? profileImageUrl;
  final DioException? error;

  const ProfileImageState({this.profileImageUrl, this.error});

  @override
  List<Object?> get props => [profileImageUrl, error];
}

class ProfileImageInitialState extends ProfileImageState {
  const ProfileImageInitialState({String? url})
      : super(profileImageUrl: url);
}

class ProfileImageSuccessState extends ProfileImageState {
  const ProfileImageSuccessState({String? url})
      : super(profileImageUrl: url);
}

class ProfileImageErrorState extends ProfileImageState {
  const ProfileImageErrorState({String? url, DioException? error})
      : super(profileImageUrl: url, error: error);
}