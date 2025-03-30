import 'package:equatable/equatable.dart';

class AirportEntity extends Equatable {
  final String? countryCode;
  final String? iata;
  final String? airport;
  final bool? isDisabled;

  const AirportEntity({
    this.countryCode,
    this.iata,
    this.airport,
    this.isDisabled,
  });

  @override
  List<Object?> get props => [
        countryCode,
        iata,
        airport,
        isDisabled,
      ];
}
