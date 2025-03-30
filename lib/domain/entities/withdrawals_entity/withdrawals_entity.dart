import 'package:equatable/equatable.dart';

class WithdrawalEntity extends Equatable {
  final String? WithdrawalsId;
  final double? Amount;
  final String? Date;
  final String? Status;
  final String? Currency;
  final List<String>? ProofOfTransaction;
  final String? CustomerId;
  final bool? Deleted;

  const WithdrawalEntity({
    this.WithdrawalsId,
    this.Amount,
    this.Date,
    this.Status,
    this.Currency,
    this.ProofOfTransaction,
    this.CustomerId,
    this.Deleted,
  });

  @override
  List<Object?> get props => [
        WithdrawalsId,
        Amount,
        Date,
        Status,
        Currency,
        ProofOfTransaction,
        CustomerId,
        Deleted,
      ];
}
