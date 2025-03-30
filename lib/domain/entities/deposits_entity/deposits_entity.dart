import 'package:equatable/equatable.dart';

class DepositEntity extends Equatable {
  final String? DepositId;
  final double? Amount;
  final String? Description;
  final String? Date;
  final String? DepositType;
  final String? Currency;
  final List<String>? ProofOfTransaction;
  final String? ProofOfConfirmation;
  final String? CustomerId;
  final String? Status;
  final bool? Deleted;

  const DepositEntity({
    this.DepositId,
    this.Amount,
    this.Description,
    this.Date,
    this.DepositType,
    this.Currency,
    this.ProofOfTransaction,
    this.ProofOfConfirmation,
    this.CustomerId,
    this.Status,
    this.Deleted,
  });

  @override
  List<Object?> get props => [
        DepositId,
        Amount,
        Description,
        Date,
        DepositType,
        Currency,
        ProofOfTransaction,
        ProofOfConfirmation,
        CustomerId,
        Status,
        Deleted,
      ];
}
