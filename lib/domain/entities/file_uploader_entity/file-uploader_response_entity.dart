import 'package:equatable/equatable.dart';

class UploadImageResponseEntity extends Equatable {
  final String? imageUrl;

  const UploadImageResponseEntity({this.imageUrl, String? imageurl});

  @override
  List<Object?> get props {
    return [
      imageUrl,
    ];
  }
}