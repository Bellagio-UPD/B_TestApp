import 'dart:ffi';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class ResponseEntity extends Equatable {
  final Uint8List? qrCode;
  final String? operation;

  const ResponseEntity({this.operation,this.qrCode});

  @override
  List<Object?> get props {
    return [
      operation,
    ];
  }
}
