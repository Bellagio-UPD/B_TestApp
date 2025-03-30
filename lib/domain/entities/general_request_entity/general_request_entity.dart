import 'package:equatable/equatable.dart';

class GeneralRequestEntity extends Equatable {
  final String? CustomerId;
  final String? CustomerRequestId;
  final String? Title;
  final String? Details;
  final String? Date;

  const GeneralRequestEntity(
      {this.CustomerId,this.CustomerRequestId, this.Title, this.Details, this.Date});
  @override
  List<Object?> get props {
    return [CustomerId,CustomerRequestId, Title, Details, Date];
  }
}
