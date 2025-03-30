import 'package:bellagio_mobile_user/data/models/sign_up_model/sign_up_model.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/sign_up.dart';

import '../../../presentation/pages/sign_in/sign_in.dart';

class FlowTypeWrapperModel {
  final FlowType flowType;
  final SignUpModel? signUpModel;
  final String? mobileNumber;

  FlowTypeWrapperModel(
      {required this.flowType, this.signUpModel, this.mobileNumber});
}
