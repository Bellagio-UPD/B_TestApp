import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/core/storage/shared_pref_manager.dart';
import 'package:bellagio_mobile_user/domain/usecases/loyalty_cards_usecase/get_assigned_loyalty_card_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/loyalty_cards_usecase/get_loyalty_cards_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/user_info_usecase/user_info_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/models/user_info_model/user_info_model.dart';
import '../../my_cards/loyalty_cards_cubit/loyalty_cards_cubit.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final UserInfoUsecase? userInfoUsecase;

  UserInfoCubit({this.userInfoUsecase}) : super(const UserInfoInitial());

  final sharedPrefManager = SharedPrefManager();
  final loyaltyCubit = LoyaltyCardsCubit(
      getAssignedLoyaltyCardsUsecase:
          getIt.get<GetAssignedLoyaltyCardsUsecase>());

  Future<void> fetchUserInfo() async {
    // emit(UserInfoInitial());
    try {
      final result = await userInfoUsecase!.call(params: null);
      if (result is DataSuccess) {
        final email = result.data!.Email;
        final mobileNumber = result.data!.Phone;
        final managerId = result.data!.ManagerId;
        final loyaltyProgramId = result.data!.LoyaltyProgramId;
        final packageId = result.data!.CustomerPackageId;
        final bellagioId = result.data!.BellagioId;
        final bellagioPoints = result.data!.Points;
        final otp = result.data!.OTPPoints;
        final registrationQR = result.data!.RegistrationQR;
        final firstname = result.data!.FirstName;
        final lastname = result.data!.LastName;
        await sharedPrefManager.saveUserName("${firstname} ${lastname}");
        await sharedPrefManager.saveEmail(email ?? '');
        await sharedPrefManager.savePhoneNumber(mobileNumber ?? '');
        await sharedPrefManager.saveManagerId(managerId ?? '');
        await sharedPrefManager.saveLoyaltyProgramId(loyaltyProgramId ?? '');
        await sharedPrefManager.savePackageId(packageId ?? '');
        await sharedPrefManager.saveBellagioId(bellagioId ?? '');
        await sharedPrefManager.saveBellagioPoints(bellagioPoints.toString());
        await sharedPrefManager.saveOTPPoints(otp.toString());
        await sharedPrefManager.saveQRCode(registrationQR ?? '');
        await sharedPrefManager.saveFirstName(firstname ?? '');
        await sharedPrefManager.saveLastName(lastname ?? '');

        print("-----------${managerId}");

        // await loyaltyCubit.getLoyaltCard();

        emit(UserInfoSuccessState(model: result.data, error: result.error));
      } else {
        emit(UserInfoErrorState(error: result.error));
      }
    } on DioException catch (e) {
      emit(UserInfoErrorState(error: e));
    }
  }

  void updateUserInfo(UserInfoModel userInfo) {
    emit(UserInfoSuccessState(
        model: userInfo)); // Update the state with the new user info
  }
}
