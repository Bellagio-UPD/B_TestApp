import 'package:equatable/equatable.dart';

class OptionsEntity extends Equatable {
  final String? Name;
  final String? Location;
  final String? Validity;

  OptionsEntity({this.Name, this.Location, this.Validity});

  @override
  List<Object?> get props {
    return [
      Name,
      Location,
      Validity
    ];
  }
}
