part of 'transactions_cubit.dart';

abstract class TransactionsState extends Equatable {
  final List<DepositModel>? depositsList;
  final List<WithdrawalModel>? withdrawalList;
  final DioException? error;

  TransactionsState({this.depositsList, this.withdrawalList, this.error});

  @override
  List<Object?> get props => [depositsList,withdrawalList, error];
}

class TransactionsInitialState extends TransactionsState {
   TransactionsInitialState(
      {List<DepositModel>? depositList,
      List<WithdrawalModel>? withdrawalList,
      DioException? error})
      : super(
            depositsList: depositList,
            withdrawalList: withdrawalList,
            error: error);
}

class TransactionsLoadedState extends TransactionsState {
   TransactionsLoadedState(
      {List<DepositModel>? depositList,
      List<WithdrawalModel>? withdrawalList,
      DioException? error})
      : super(
            depositsList: depositList,
            withdrawalList: withdrawalList,
            error: error);
}

class TransactionsErrorState extends TransactionsState {
   TransactionsErrorState({DioException? error}) : super(error: error);
}
