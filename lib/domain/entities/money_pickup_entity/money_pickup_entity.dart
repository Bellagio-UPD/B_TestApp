import 'package:equatable/equatable.dart';

class MoneyPickupEntity extends Equatable {
  final String? address;
  final String? time;
  final String? date;
  final String? note;

  const MoneyPickupEntity({this.address, this.time, this.date, this.note});

  @override
  List<Object?> get props {
    return [address, time, date, note];
  }
}
