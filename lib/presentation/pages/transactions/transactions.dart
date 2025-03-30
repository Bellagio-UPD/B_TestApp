import 'package:bellagio_mobile_user/core/constants/font_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/domain/usecases/deposits_usecase/get_deposits_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/withdrawal_usecase/get_withdrawal_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/transactions/transactions_cubit/transactions_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/transactions_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/color_manager.dart';
import '../../widgets/custom_appbar.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  String formatDate(String? date) {
    if (date == null || date.isEmpty ) return "" ;
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
    if (time == null || time == "") return "";
    DateTime parsedDate = DateTime.parse(time).toLocal();
    return DateFormat('h:mm a').format(parsedDate); // Example: "6:30 PM"
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => TransactionsCubit(
            getDepositsUsecase: getIt.get<GetDepositsUsecase>(),
            getWithdrawalUsecase: getIt.get<GetWithdrawalUsecase>())
          ..getDeposits()
          ..getWithdrawals(),
        child: Scaffold(
          appBar: CustomAppbar(
            title: "Transactions",
            showLeadingIcon: false,
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundColor,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 25.0),
                  // padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: AppColors.tileColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelColor: AppColors.textColor,
                    unselectedLabelColor: AppColors.secondaryColor,
                    labelStyle: const TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      fontWeight: FontWeights.semiBold,
                      fontSize: FontSizes.s14,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      fontWeight: FontWeights.semiBold,
                      fontSize: FontSizes.s14,
                    ),
                    tabs: const [
                      Tab(text: "Deposit"),
                      Tab(text: "Withdraw"),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: BlocProvider(
                            create: (context) => TransactionsCubit(
                                getDepositsUsecase:
                                    getIt.get<GetDepositsUsecase>())
                              ..getDeposits(),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                BlocBuilder<TransactionsCubit,
                                    TransactionsState>(
                                  builder: (context, state) {
                                    if (state is TransactionsInitialState) {
                                      // Show a loading indicator while data is being fetched
                                      return const Center(
                                        child: CupertinoActivityIndicator(
                                            color: AppColors.dateTimeColor),
                                      );
                                    } else if (state
                                        is TransactionsErrorState) {
                                      // Show an error message if there is an error
                                      return Center(
                                        child: Text(
                                          "Failed to load deposits.",
                                          style: getContentTextMedium(),
                                        ),
                                      );
                                    } else if (state
                                        is TransactionsLoadedState) {
                                      // Check if depositsList is null or empty
                                      if (state.depositsList == null) {
                                        return Center(
                                          child: Text(
                                            "No deposits to load.",
                                            style: getContentTextMedium(),
                                          ),
                                        );
                                      }

                                      // Data is available, display it
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(), // Prevents nested scrolling
                                        itemCount: state.depositsList!.length,
                                        itemBuilder: (context, index) {
                                          final deposit =
                                              state.depositsList![index];
                                          return TransactionsTile(
                                              type: "Deposit",
                                              amount:"+${deposit.Currency} ${deposit.Amount.toString()}" ,
                                              // time: formatTime(deposit.Date),
                                              date: deposit.Date ?? '');
                                        },
                                      );
                                    }
                                    // Handle unexpected states
                                    return CupertinoActivityIndicator(
                                        color: AppColors.dateTimeColor);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: BlocProvider(
                            create: (context) => TransactionsCubit(
                                getWithdrawalUsecase:
                                    getIt.get<GetWithdrawalUsecase>())
                              ..getWithdrawals(),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                BlocBuilder<TransactionsCubit,
                                    TransactionsState>(
                                  builder: (context, state) {
                                    if (state is TransactionsInitialState) {
                                      return CupertinoActivityIndicator(
                                        color: AppColors.dateTimeColor,
                                      );
                                    } else if (state
                                        is TransactionsErrorState) {
                                      return Text(
                                        "Failed to load withdrawals.",
                                        style: getContentTextMedium(),
                                      );
                                    } else if (state
                                        is TransactionsLoadedState) {
                                      if (state.withdrawalList == null) {
                                        return Text(
                                          "No withdrawals to load.",
                                          style: getContentTextMedium(),
                                        );
                                      }
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.withdrawalList!.length,
                                        itemBuilder: (context, index) {
                                          final withdrawal =
                                              state.withdrawalList![index];
                                          return TransactionsTile(
                                              type:
                                                  "Withdrawal", // This can be customized
                                              amount:
                                                "-${withdrawal.Currency} ${withdrawal.Amount.toString()}"  ,
                                              // time: formatTime(withdrawal.Date),
                                              date: withdrawal.Date ?? '');
                                        },
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
                    ],
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
