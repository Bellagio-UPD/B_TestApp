import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class FileModel extends HiveObject {
  @HiveField(0)
  late String cloudLocation;

  @HiveField(1)
  late String localLocation;

  FileModel({
    required this.cloudLocation,
    required this.localLocation,
  });

  @override
  String toString() {
    return 'FileModel{cloudLocation: $cloudLocation, localLocation: $localLocation}';
  }
}