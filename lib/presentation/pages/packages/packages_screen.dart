import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/data/models/request_model/sub_models/deposit_details_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/packages_usecase/get_packages_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/packages/packages_cubit/packages_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_snackbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/package_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/constants/style_manager.dart';
import '../../routes/routes.dart';

class PackagesScreen extends StatelessWidget {
  PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(showLeadingIcon: true, title: "Packages"),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: BlocProvider(
            create: (context) => PackagesCubit(
                getPackagesUsecase: getIt.get<GetPackagesUsecase>())
              ..getPackages(),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                // Expanded(child: PackagesList())
                BlocBuilder<PackagesCubit, PackagesState>(
                  builder: (context, state) {
                    if (state is PackagesInitialState) {
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.dateTimeColor,
                        ),
                      );
                    } else if (state is PackagesErrorState) {
                      return Text(
                        "Failed to load packages.",
                        style: getContentTextMedium(),
                      );
                    } else if (state is PackagesLoadedState) {
                      if (state.packagesList == null ||
                          state.packagesList!.isEmpty) {
                        showHoveringSnackbar(
                            context, "Failed to load packages");
                        return Text("No packages available",
                            style: getContentTextMedium());
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.packagesList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final package = state.packagesList![index];
                            final formattedPrice = NumberFormat.currency(
                              symbol:
                                  '${package.Currency} ', // Display "INR" before the amount
                              decimalDigits: 0, // Two decimal places
                            ).format(package.Price);
                            return PackageTile(
                                ontap: () {
                                  GoRouter.of(context).pushNamed(
                                      Routes.moneyDeposit,
                                      extra: DepositDetails(
                                          PackageId: package.PackageId,
                                          PackageName: package.Name));
                                },
                                title: package.Name ?? '',
                                value: "${formattedPrice.toString()}",
                                selected: package.IsActive ?? false,
                                content: package.Description ?? '');
                          },
                        ),
                      );
                    }
                    return CupertinoActivityIndicator();
                  },
                ),
              ],
            ),
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
