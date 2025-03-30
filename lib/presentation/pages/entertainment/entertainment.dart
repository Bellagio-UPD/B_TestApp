import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/domain/usecases/events_usecase/get_events_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/entertainment/events_cubit/events_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/color_manager.dart';
import '../../widgets/custom_border_button.dart';

class EntertainmentScreen extends StatelessWidget {
  EntertainmentScreen({super.key});
  bool _hasEventImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(title: "Entertainment"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: BlocProvider(
            create: (context) =>
                EventsCubit(getEventsUsecase: getIt.get<GetEventsUsecase>())
                  ..getEvents(),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                BlocBuilder<EventsCubit, EventsState>(
                  builder: (context, state) {
                    if (state is EventsInitialState) {
                      return CupertinoActivityIndicator(
                        color: AppColors.dateTimeColor,
                      );
                    } else if (state is EventsErrorState) {
                      return Text(
                        "Failed to load events.",
                        style: getContentTextMedium(),
                      );
                    } else if (state is EventsLoadedState) {
                      if (state.eventsList == null) {
                        return Text("No events available",
                            style: getContentTextMedium());
                      }
                      return Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 0.9),
                            itemCount: state.eventsList!.length,
                            itemBuilder: (context, index) {
                              if (state.eventsList![index].Poster == null ||
                                  state.eventsList![index].Poster!.isEmpty)
                                _hasEventImage = true;
                              return EntertainmentTile(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              insetPadding: EdgeInsets.zero,
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context).pop(),
                                                child: Center(
                                                    child: !_hasEventImage
                                                        ? Image.network(
                                                            state
                                                                    .eventsList![
                                                                        index]
                                                                    .Poster![0]
                                                                as String,
                                                            fit: BoxFit.cover,
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
                                  hasImage: !_hasEventImage,
                                  image: !_hasEventImage
                                      ? state.eventsList![index].Poster![0]
                                          as String
                                      : 'assets/images/image_placeholder.jpg');
                            }),
                      );
                    }
                    return CupertinoActivityIndicator(
                        color: AppColors.dateTimeColor);
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
