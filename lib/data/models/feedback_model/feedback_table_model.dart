import 'package:equatable/equatable.dart';
import '../../../domain/entities/feedback_entity/game_entity.dart';
import '../../../domain/entities/feedback_entity/tables_entity.dart';

class FeedbackTableModel extends Equatable {
  final GameEntity? game;
  final List<TableEntity>? tables;

  const FeedbackTableModel({this.game, this.tables});

  factory FeedbackTableModel.fromJson(Map<String, dynamic> json) {
    return FeedbackTableModel(
      game: json['Game'] != null ? GameEntity.fromJson(json['Game']) : null,
      tables: json['Tables'] != null
          ? (json['Tables'] as List<dynamic>)
          .map((table) => TableEntity.fromJson(table as Map<String, dynamic>))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Game': game?.toJson(),
      'Tables': tables?.map((table) => table.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [game, tables];
}
