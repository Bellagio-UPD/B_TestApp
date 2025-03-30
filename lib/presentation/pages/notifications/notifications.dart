import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/data/sources/notifications_service/notifications_socket_service.dart';
import 'package:bellagio_mobile_user/domain/usecases/notifications_usecase/get_notifications_by_socket_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/notifications_usecase/get_notifications_usecase.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/repositories/notifications_repository/notifications_repository.dart';
import '../../widgets/notifications_tile.dart';
import 'notifications_cubit/notifications_cubit.dart';
import 'notifications_socket_cubit/notifications_socket_cubit.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late ScrollController _scrollController;

    @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<NotificationsCubit>().getNotifications(isLoadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String formatDate(String? date) {
    if (date == null) return "";
    DateTime parsedDate = DateTime.parse(date).toLocal();
    String dayWithSuffix = _addOrdinalSuffix(parsedDate.day);
    return "$dayWithSuffix ${DateFormat('MMM, yyyy').format(parsedDate)}";
  }

  String _addOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) return '${day}th';
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  String formatTime(String? time) {
    if (time == null) return "";
    DateTime parsedDate = DateTime.parse(time).toLocal();
    return DateFormat('h:mm a').format(parsedDate); // Example: "6:30 PM"
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit(
          getNotificationsUsecase: getIt.call<GetNotificationsUsecase>())
        ..getNotifications(),
      child: Scaffold(
        appBar: const CustomAppbar(
          title: "Notifications",
          showLeadingIcon: false,
        ),
        body: Container(
          decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Expanded(
                  child: BlocBuilder<NotificationsCubit, NotificationsState>(
                    builder: (context, state) {
                      if (state is NotificationsInitialState) {
                        return Center(
                          child: CupertinoActivityIndicator(
                            color: AppColors.dateTimeColor,
                          ),
                        );
                      } else if (state is NotificationsErrorState) {
                        return Center(
                            child: Text(
                          "Failed to load notifications.",
                          style: getContentTextMedium(),
                        ));
                      } else if (state is NotificationsLoadedState) {
                        if (state.notificationList == null ||
                            state.notificationList!.isEmpty) {
                          return Center(
                            child: Text(
                              "No notifications available.",
                              style: getContentTextMedium(),
                            ),
                          );
                        }
                        return ListView.builder(
                            controller: _scrollController,
                            itemCount: state.notificationList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final notification =
                                  state.notificationList![index];
                              return NotificationsTile(
                                  notification: notification.Content ?? '',
                                  date: formatDate(notification.TimeStamp),
                                  time: formatTime(notification.TimeStamp));
                            });
                      }
                      return CupertinoActivityIndicator(
                        color: AppColors.dateTimeColor,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
