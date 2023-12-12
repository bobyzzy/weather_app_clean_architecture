import 'package:geolocator/geolocator.dart';

abstract class GeolocationInfo {
  Future<Position> geolocatorInfo();
}

class GeolocationImpl implements GeolocationInfo {
  GeolocationImpl();

  @override
  Future<Position> geolocatorInfo() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!serviceEnabled) {
      throw Future.error('Location service are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Future.error('Location Permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition();
    return position;
  }
}
