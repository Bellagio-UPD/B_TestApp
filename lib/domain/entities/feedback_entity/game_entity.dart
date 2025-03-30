import 'package:bellagio_mobile_user/domain/entities/feedback_entity/tables_entity.dart';
import 'package:equatable/equatable.dart';

class GameEntity extends Equatable {
  final String? gameId;
  final String? name;
  final String? description;
  final int? minPlayers;
  final int? maxPlayers;
  final bool? isActive;
  final bool? deleted;

  const GameEntity({
    this.gameId,
    this.name,
    this.description,
    this.minPlayers,
    this.maxPlayers,
    this.isActive,
    this.deleted,
  });

  factory GameEntity.fromJson(Map<String, dynamic> json) {
    return GameEntity(
      gameId: json['GameId'],
      name: json['Name'],
      description: json['Description'],
      minPlayers: json['MinPlayers'],
      maxPlayers: json['MaxPlayers'],
      isActive: json['IsActive'],
      deleted: json['deleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GameId': gameId,
      'Name': name,
      'Description': description,
      'MinPlayers': minPlayers,
      'MaxPlayers': maxPlayers,
      'IsActive': isActive,
      'deleted': deleted,
    };
  }

  @override
  List<Object?> get props =>
      [gameId, name, description, minPlayers, maxPlayers, isActive, deleted];
}
