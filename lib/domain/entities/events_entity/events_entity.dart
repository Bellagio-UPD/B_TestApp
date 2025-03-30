import 'package:equatable/equatable.dart';

class EventsEntity extends Equatable {
  final String? EventId;
  final String? Name;
  final String? Date;
  final String? Description;
  final String? Category;
  final String? Status;
  final List<String>? Poster;
  final bool? Deleted;

  const EventsEntity({
    this.EventId,
    this.Name,
    this.Date,
    this.Description,
    this.Category,
    this.Status,
    this.Poster,
    this.Deleted,
  });

  @override
  List<Object?> get props {
    return [
      EventId,
      Name,
      Date,
      Description,
      Category,
      Status,
      Poster,
      Deleted,
    ];
  }
}
