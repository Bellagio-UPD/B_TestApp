import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/domain/usecases/tournaments_usecase/get_tournaments_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/tournemants/tournemants_cubit/tournaments_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/color_manager.dart';
import '../../widgets/custom_border_button.dart';

class TournamentsScreen extends StatelessWidget {
  TournamentsScreen({super.key});
  bool _hasDrawImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(title: "Tournaments & Draws"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: BlocProvider(
            create: (context) => TournamentsCubit(
                getTournamentsUsecase: getIt.get<GetTournamentsUsecase>())
              ..getTournaments(),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                BlocBuilder<TournamentsCubit, TournamentsState>(
                  builder: (context, state) {
                    if (state is TournamentsInitialState) {
                      return CupertinoActivityIndicator(
                        color: AppColors.dateTimeColor,
                      );
                    } else if (state is TournamentsErrorState) {
                      Text(
                        "Failed to load tournaments.",
                        style: getContentTextMedium(),
                      );
                    } else if (state is TournamentsLoadedState) {
                      if (state.tournamentList == null ||
                          state.tournamentList!.isEmpty) {
                        return Center(
                          child: Text(
                            "No tournaments available.",
                            style: getContentTextMedium(),
                          ),
                        );
                      }
                      return Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 0.9),
                            itemCount: state.tournamentList!.length,
                            itemBuilder: (context, index) {
                              if (state.tournamentList![index].Poster == null ||
                                  state.tournamentList![index].Poster!.isEmpty)
                                _hasDrawImage = true;
                              return EntertainmentTile(
                                  hasImage: !_hasDrawImage,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                              backgroundColor: Colors
                                                  .transparent, // Make the dialog background transparent
                                              insetPadding: EdgeInsets
                                                  .zero, // Ensure the dialog takes up the entire screen
                                              child: GestureDetector(
                                                onTap: () => Navigator.of(
                                                        context)
                                                    .pop(), // Allow closing the dialog by tapping on the image
                                                child: Center(
                                                    child: !_hasDrawImage
                                                        ? Image.network(
                                                            state
                                                                        .tournamentList![
                                                                            index]
                                                                        .Poster![0]
                                                                    as String? ??
                                                                'assets/images/hiphop.png',
                                                            fit: BoxFit
                                                                .cover, // Ensure the image covers the available space
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                          )
                                                        : Image.asset(
                                                            "assets/images/image_placeholder.jpg",
                                                            fit: BoxFit.cover,
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                          )),
                                              ));
                                        });
                                  },
                                  image: !_hasDrawImage
                                      ? state.tournamentList![index].Poster![0]
                                          as String
                                      : 'assets/images/hiphop.png');
                              // return CustomBorderButton(
                              //   // image: "assets/images/iphone.png",
                              //   // image: state.tournamentList![index].Poster![index],
                              //   title: state.tournamentList![index].Name ?? '',
                              //   showButton: true,
                              //   onPressed: (){},
                              // );
                            }),
                      );
                    }
                    return CupertinoActivityIndicator(
                      color: AppColors.dateTimeColor,
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
