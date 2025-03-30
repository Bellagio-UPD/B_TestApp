import 'package:bellagio_mobile_user/domain/usecases/deposits_usecase/get_deposits_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/withdrawal_usecase/get_withdrawal_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/deposits_model/deposits_model.dart';
import '../../../../data/models/withdrawals_model/withdrawal_model.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final GetDepositsUsecase? getDepositsUsecase;
  final GetWithdrawalUsecase? getWithdrawalUsecase;

  TransactionsCubit({this.getDepositsUsecase, this.getWithdrawalUsecase})
      : super(TransactionsInitialState());

  Future<void> getDeposits() async {
    try {
      final allDeposits = await getDepositsUsecase!.call(params: null);
      if (allDeposits is DataSuccess || allDeposits.data != null) {
        emit(TransactionsLoadedState(
            depositList: allDeposits.data, error: allDeposits.error));
      } else {
        if (allDeposits.data == null || allDeposits.data!.isEmpty) {
          emit(TransactionsLoadedState(
              depositList: allDeposits.data, error: allDeposits.error));
        } else {
          emit(TransactionsErrorState(error: allDeposits.error));
        }
      }
    } on DioException catch (e) {
      emit(TransactionsErrorState(error: e));
    }
  }

  Future<void> getWithdrawals() async {
    try {
      final allWithdrawals = await getWithdrawalUsecase!.call(params: null);
      if (allWithdrawals is DataSuccess || allWithdrawals.data != null) {
        emit(TransactionsLoadedState(
            withdrawalList: allWithdrawals.data, error: allWithdrawals.error));
      } else {
        if (allWithdrawals.data == null || allWithdrawals.data!.isEmpty) {
          emit(TransactionsLoadedState(
              withdrawalList: allWithdrawals.data,
              error: allWithdrawals.error));
        } else {
          emit(TransactionsErrorState(error: allWithdrawals.error));
        }
      }
    } on DioException catch (e) {
      emit(TransactionsErrorState(error: e));
    }
  }
}
