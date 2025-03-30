import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/cupertino.dart';

import '../../core/constants/color_manager.dart';

class HorizontalOffersView extends StatelessWidget {
  const HorizontalOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 25,
          ),
          HomeOfferTile(
              image: "assets/images/image_placeholder.jpg",
              offer: "Summer Sale"),
         HomeOfferTile(
              image: "assets/images/image_placeholder.jpg",
              offer: "Vogue Jewellers"),
               HomeOfferTile(
              image: "assets/images/image_placeholder.jpg",
              offer: "Kingsbury Hotel"),
        ],
      ),
    );
  }
}

class HomeOfferTile extends StatelessWidget {
  final String image;
  final String offer;
  const HomeOfferTile({super.key, required this.image, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.26,
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          color: AppColors.tileColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.32,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: AssetImage(image))),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  offer,
                  style: getContentTextMedium(),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
