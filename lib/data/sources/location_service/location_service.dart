import 'dart:async';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/dependency_injection/service_locator.dart';
import '../../../core/storage/shared_pref_manager.dart';

class LocationService {
  final Dio _dio = getIt<Dio>();
  final SharedPrefManager _sharedPrefManager = getIt<SharedPrefManager>();

  Future<void> sendLocation() async {
    final userId = await _sharedPrefManager.getUserId();
    if (userId != null && userId.isNotEmpty) {
      try {
        if (!(await _checkAndRequestLocationPermission())) {
          return;
        }

        if (!(await Geolocator.isLocationServiceEnabled())) {
          return;
        }

        // Get current position (ensure it's on the main thread/engine)
        Position position = await Geolocator.getCurrentPosition();

        final options = Options();

        final response = await _dio.post(
          'https://bellagio-upd.tyk.cgaas.ai/gateway/customerrequestmanagement-app1732/upsert/Location',
          data: {
            'CustomerId': userId,
            'Latitude': position.latitude,
            'Longitude': position.longitude,
          },
          options: options, // Ensures options are not overridden
        );

      } catch (e) {
      }
    }
  }

  Future<bool> _checkAndRequestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await Permission.location.request();
      return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return false;
  }

  void startPeriodicLocationUpdates() {
    Timer.periodic(Duration(minutes: 10), (timer) async {
      await sendLocation();
    });
  }
}
