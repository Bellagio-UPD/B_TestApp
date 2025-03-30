import 'package:equatable/equatable.dart';

class FCMTokenRegisterEntity extends Equatable {
  final String? Token;
  final String? CustomerID;


  const FCMTokenRegisterEntity({
    this.Token,
    this.CustomerID,
  });

  @override
  List<Object?> get props {
    return [
      Token,
      CustomerID,
    ];
  }
}
