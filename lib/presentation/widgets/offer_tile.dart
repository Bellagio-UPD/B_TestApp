import 'package:flutter/cupertino.dart';

import '../../core/constants/color_manager.dart';
import '../../core/constants/style_manager.dart';

class OfferTile extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String offer;
  const OfferTile({super.key, required this.image, required this.offer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.26,
        width: MediaQuery.of(context).size.width * 0.4,
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
                        image: AssetImage(image), fit: BoxFit.fill)),
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
