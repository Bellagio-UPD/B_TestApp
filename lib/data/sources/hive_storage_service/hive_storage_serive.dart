import 'package:hive/hive.dart';

class HiveStorageService {
  final Box _box = Hive.box('bellagio_user_bucket');

  Future<void> saveDownloadPath(String message, String path) async {
    await _box.put(message, path);
  }

  String? getDownloadPath(String message) {
    return _box.get(message);
  }
}
