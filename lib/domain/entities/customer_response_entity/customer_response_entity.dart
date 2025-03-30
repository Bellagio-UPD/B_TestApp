import 'package:equatable/equatable.dart';

import '../user_info_entity/user_info_entity.dart';

class CustomerResponseEntity extends Equatable {
  final UserInfoEntity? userInfoEntity;
  final String? status;

  const CustomerResponseEntity({
    this.userInfoEntity,
    this.status,
  });

  @override
  List<Object?> get props => [userInfoEntity, status];
}
