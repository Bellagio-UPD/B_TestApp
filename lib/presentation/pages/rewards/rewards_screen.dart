import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color_manager.dart';
import '../../widgets/custom_border_button.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(title: "Rewards"),
      body: Container(
        width: 1000,
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(
                  // height: MediaQuery.sizeOf(context).height * 0.5,
                  ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      // childAspectRatio: 0.9
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return CustomBorderButton(
                        image: "assets/images/iphone.png",
                        title: "Iphone",
                        showButton: false,
                        onPressed: (){},
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
