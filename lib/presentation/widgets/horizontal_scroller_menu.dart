import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_icon/gradient_icon.dart';

import '../routes/routes.dart';

class HorizontalScrollerMenu extends StatefulWidget {
  const HorizontalScrollerMenu({super.key});

  @override
  State<HorizontalScrollerMenu> createState() => _HorizontalScrollerMenuState();
}

class _HorizontalScrollerMenuState extends State<HorizontalScrollerMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed(Routes.packages);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.accentColor),
                    child: const Center(
                      child: Icon(
                        Icons.shopping_bag_rounded,
                        color: AppColors.secondaryColor,
                        size: 35,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Packages",
                    style: getButtonLabelMedium(),
                  )
                ],
              ),
            ),
          ),
          // RoundMenuButton(
          //     onTap: () {
          //       GoRouter.of(context).pushNamed(Routes.generalRequest);
          //     },
          //     icon: Icons.request_quote_outlined,
          //     title: "Request"),
          RoundMenuButton(
              onTap: () {
                GoRouter.of(context).pushNamed(Routes.airTicketScreen);
              },
              icon: Icons.flight,
              title: "Air tickets"),
          RoundMenuButton(
              onTap: () {
                GoRouter.of(context).pushNamed(Routes.transportRequest);
              },
              icon: Icons.drive_eta,
              title: "Transport"),
          RoundMenuButton(
              onTap: () {
                GoRouter.of(context).pushNamed(Routes.hotelReservation);
              },
              icon: Icons.hotel_class_rounded,
              title: "Hotels"),
          RoundMenuButton(
              onTap: () {
                GoRouter.of(context).pushNamed(Routes.offersScreen);
              },
              icon: Icons.percent_rounded,
              title: "Offers"),
          RoundMenuButton(
              onTap: () {
                GoRouter.of(context).pushNamed(Routes.gifts);
              },
              icon: Icons.wallet_giftcard_rounded,
              title: "Gifts"),
          RoundMenuButton(
              onTap: () {
                GoRouter.of(context).pushNamed(Routes.entertainment);
              },
              icon: Icons.attractions_outlined,
              title: "Entertainment"),
          RoundMenuButton(
              onTap: () {
                GoRouter.of(context).pushNamed(Routes.tournaments);
              },
              icon: Icons.confirmation_num_outlined,
              title: "Draws"),
          RoundMenuButton(
              onTap: () {
                GoRouter.of(context).pushNamed(Routes.feedback);
              }, icon: Icons.chat_outlined, title: "Feedback"),
        ],
      ),
    );
  }
}

class RoundMenuButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final double size;
  const RoundMenuButton(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title,
      this.size = 60});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size,
              width: size,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.secondaryColor),
              child: Center(
                child: GradientIcon(
                  offset: const Offset(0, 0),
                  icon: icon,
                  gradient: AppColors.accentColor,
                  size: size * 0.5,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: getButtonLabelMedium(),
            )
          ],
        ),
      ),
    );
  }
}
