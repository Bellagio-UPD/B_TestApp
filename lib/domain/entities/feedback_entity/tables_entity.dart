import 'package:equatable/equatable.dart';

class TableEntity extends Equatable {
  final String? cassinoTableId;
  final String? tableNumber;
  final String? gameId;
  final int? maxPlayers;
  final bool? deleted;

  const TableEntity({
    this.cassinoTableId,
    this.tableNumber,
    this.gameId,
    this.maxPlayers,
    this.deleted,
  });

  factory TableEntity.fromJson(Map<String, dynamic> json) {
    return TableEntity(
      cassinoTableId: json['CassinoTableId'],
      tableNumber: json['TableNumber'].toString(), // Ensure string conversion
      gameId: json['GameId'],
      maxPlayers: json['MaxPlayers'],
      deleted: json['deleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CassinoTableId': cassinoTableId,
      'TableNumber': tableNumber,
      'GameId': gameId,
      'MaxPlayers': maxPlayers,
      'deleted': deleted,
    };
  }

  @override
  List<Object?> get props => [cassinoTableId, tableNumber, gameId, maxPlayers, deleted];
}
