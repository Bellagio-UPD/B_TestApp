import 'package:bellagio_mobile_user/data/models/request_model/sub_models/deposit_details_model.dart';
import 'package:bellagio_mobile_user/data/models/user_info_model/user_info_model.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/package_tile.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/constants/style_manager.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../routes/routes.dart';

class PaymentMode extends StatefulWidget {
  final DepositDetails depositDetails;
  PaymentMode({super.key, required this.depositDetails});

  @override
  State<PaymentMode> createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {
  String? _userId = "";
  String? _userName = "";
  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  void _getUserId() async {
    final sharedPrefManager = SharedPrefManager();
    final userId = await sharedPrefManager.getUserId();
    final userName =
        await sharedPrefManager.getUserName(); // Resolve the Future here
    if (userId != null && userName != null) {
      setState(() {
        _userId = userId;
        _userName = userName; // Assign the actual value, not the Future
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(showLeadingIcon: true, title: "Payment mode"),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              // Expanded(child: PackagesList())
              Text(
                "Please select a payment mode to continue.",
                style: getContentTextLarge(),
              ),
              SizedBox(
                height: 40,
              ),
              // Container(),
              PrimaryButton(
                  label: "Buy package",
                  onPressed: () {
                    GoRouter.of(context).pushNamed(Routes.moneyDeposit,
                        extra: UserInfoModel(
                            CustomerId: _userId, FirstName: _userName, CustomerPackageId: widget.depositDetails.PackageId, Country: widget.depositDetails.PackageName));
                  },
                  buttonStyleType: ButtonStyleType.filled)
            ],
          ),
        ),
      ),
    );
    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     extendBodyBehindAppBar: true,
    //     appBar: CustomAppbar(showLeadingIcon: true, title: "Packages"),
    //     body: Container(
    //       width: double.infinity,
    //       decoration: BoxDecoration(gradient: AppColors.backgroundColor),
    //     ),
    //   ),
    // );
  }
}
