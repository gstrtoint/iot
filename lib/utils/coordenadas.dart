
/**
 * @author Gilmar N. Lima
 * @email gstrtoint@gmail.com or adminti@isofttec.com.br
 * @create date 25-06-2023  14:35:21
 * @modify date 25-06-2023  14:35:21
 * @desc [description]
 */
import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GetCoordenadas {
  GetCoordenadas();

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Serviço de localização não esta habilitado!.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> checkIfWithinRadius(
      double referenceLatitude, double referenceLongitude) async {
    Completer<bool> completer = Completer<bool>();
    // Obtenha a posição atual do dispositivo
    Position currentPosition = await determinePosition();

    // Calcule a distância entre as duas localizações em metros
    double distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      referenceLatitude,
      referenceLongitude,
    );

    // Verifique se a distância está dentro do raio de 50 metros
    if (distance <= 50) {
      completer.complete(true);
    } else {
      completer.complete(false);
    }
    return completer.future;
  }
}
