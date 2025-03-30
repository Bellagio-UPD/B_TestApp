import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model_new.dart';
import 'package:bellagio_mobile_user/data/models/gifts_model/options_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/constants/style_manager.dart';
import '../../../core/dependency_injection/service_locator.dart';
import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../../data/models/qr_code_response_model/qr_code_return_model.dart';
import '../../../domain/usecases/gifts_usecase/redeem_gift_usecase.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/gift_options_tile.dart';
import 'redeem_QR_cubit/redeem_QR_cubit.dart';

class ViewGiftsScreen extends StatefulWidget {
  final GiftsModelNew? giftModel;
  const ViewGiftsScreen({super.key, this.giftModel});

  @override
  State<ViewGiftsScreen> createState() => _ViewGiftsScreenState();
}

class _ViewGiftsScreenState extends State<ViewGiftsScreen> {
  bool loadedCode = false;
  String _loyaltyId = "";
  String _bellagioId = "";

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    final sharedPrefManager = SharedPrefManager();
    final loyaltyId = await sharedPrefManager.getLoyaltyProgramId();
    final bellagioId = await sharedPrefManager.getBellagioId();
    if (loyaltyId != null && bellagioId != null) {
      setState(() {
        _loyaltyId = loyaltyId;
        _bellagioId = bellagioId;
      });
    } else {
  
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(title: widget.giftModel?.TypeOfGift ?? ''),
      body: BlocProvider(
        create: (context) => RedeemQrCubit(
          redeemGiftUsecase: getIt.call<RedeemGiftUsecase>(),
        ),
        child: Container(
          width: 1000,
          decoration: BoxDecoration(gradient: AppColors.backgroundColor),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                if (widget.giftModel!.Option == null ||
                    widget.giftModel!.Option!.isEmpty)
                  // Display "No gifts available" message
                  Center(
                    child: Text(
                      "No gifts available for this category",
                      style: getContentTextMedium(),
                    ),
                  )
                else
                  // Display the list of options
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.giftModel!.Option!.length,
                    itemBuilder: (context, index) {
                      final optionModel = widget.giftModel!.Option![index];
                      return GiftOptionsTile(
                        option: optionModel.Name ?? '',
                        validity: optionModel.Validity ?? '',
                        location: optionModel.Location ?? '',
                        onPressed: () async {
                          final giftModel = QrCodeReturnModel(
                            BellagioId: _bellagioId,
                            Name: optionModel.Name,
                            VoucherAmount: 0,
                            LoyaltyProgramId: _loyaltyId,
                            GiftType: widget.giftModel!.TypeOfGift,
                          );
                          final result = await context
                              .read<RedeemQrCubit>()
                              .redeemQR(giftModel);
                          if (result is DataSuccess) {
                            setState(() {
                              loadedCode = true;
                            });
                          } else {
                            setState(() {
                              loadedCode = false;
                            });
                          }
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: AppColors.purple2,
                                title: Text(
                                  "Redeem gift",
                                  style: getContentTextLarge(),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    !loadedCode
                                        ? Center(
                                            child: Text(
                                              "No QR code available.",
                                              style: getButtonLabelMedium(),
                                            ),
                                          )
                                        : Text(
                                            "Scan the QR code below and redeem your gift.",
                                            style: getButtonLabelMedium(),
                                          ),
                                    const SizedBox(height: 20),
                                    loadedCode
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: loadedCode &&
                                                      result.data?.qrCode !=
                                                          null
                                                  ? Image.memory(
                                                      result.data!.qrCode)
                                                  : const SizedBox(),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
