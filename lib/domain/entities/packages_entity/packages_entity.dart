import 'package:equatable/equatable.dart';

class PackagesEntity extends Equatable {
  final String? PackageId;
  final String? Name;
  final String? Description;
  final double? Price;
  final String? Currency;
  final String? StartDate;
  final bool? IsActive;
  final bool? Deleted;

  const PackagesEntity({
    this.PackageId,
    this.Name,
    this.Description,
    this.Price,
    this.Currency,
    this.StartDate,
    this.IsActive,
    this.Deleted,
  });

  @override
  List<Object?> get props {
    return [
      PackageId,
      Name,
      Description,
      Price,
      Currency,
      StartDate,
      IsActive,
      Deleted,
    ];
  }
}
