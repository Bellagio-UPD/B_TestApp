import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/data/models/offers_model/offers_model.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color_manager.dart';
import '../../widgets/custom_appbar.dart';

class Offer extends StatelessWidget {
  final OffersModel offer;
  const Offer({super.key,required this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  CustomAppbar(title: offer!.Title??''),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                        image:
                            AssetImage("assets/images/image_placeholder.jpg"),
                        fit: BoxFit.fill)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(offer!.Description ?? '',
                  style: getContentTextMedium()),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              PrimaryButton(
                  label: "Redeem",
                  onPressed: () {},
                  buttonStyleType: ButtonStyleType.filled)
            ],
          ),
        ),
      ),
    );
  }
}
