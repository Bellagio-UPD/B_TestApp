import 'package:bellagio_mobile_user/domain/entities/gifts_entity/options_entity.dart';
import 'package:equatable/equatable.dart';

class GiftsEntityNew extends Equatable {
  final String? TypeOfGift;
  final String? Avaialability;
  final List<OptionsEntity>? Option;

  GiftsEntityNew({this.TypeOfGift, this.Avaialability, this.Option});

  @override
  List<Object?> get props {
    return [TypeOfGift, Avaialability, Option];
  }
}
