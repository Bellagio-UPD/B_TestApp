import 'package:equatable/equatable.dart';

class TournamentsEntity extends Equatable {
  final String? TournamentId;
  final String? Name;
  final String? StartDate;
  final String? EndDate;
  final String? Prize;
  final List<String>? Poster;
  final String? Status;
  final bool? Deleted;

  const TournamentsEntity({
    this.TournamentId,
    this.Name,
    this.StartDate,
    this.EndDate,
    this.Prize,
    this.Poster,
    this.Status,
    this.Deleted,
  });

  @override
  List<Object?> get props {
    return [
      TournamentId,
      Name,
      StartDate,
      EndDate,
      Prize,
      Poster,
      Status,
      Deleted,
    ];
  }
}
