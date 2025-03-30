import 'package:bellagio_mobile_user/data/models/gifts_model/options_model.dart';
import 'package:bellagio_mobile_user/domain/entities/gifts_entity/gift_entity_new.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gifts_model_new.g.dart';

@JsonSerializable()
class GiftsModelNew extends GiftsEntityNew {
final String? TypeOfGift;
final String? Avaialability;
final List<OptionsModel>? Option;

   GiftsModelNew({
    this.TypeOfGift,
    this.Avaialability,
    this.Option
  }) : super(
        TypeOfGift: TypeOfGift,
        Avaialability: Avaialability,
        Option: Option
        );

  factory GiftsModelNew.fromJson(Map<String, dynamic> json) =>
      _$GiftsModelNewFromJson(json);

  Map<String, dynamic> toJson() => _$GiftsModelNewToJson(this);
}
