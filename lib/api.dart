import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wether/modelclass.dart';

class SProvider extends ChangeNotifier {
  final apiID = '1c8ebe33bcbcb6803d2787b2c55b1d6d';

  Smodel? smo;
  bool vattam = false;
  Future<void> fetchUser({required String city}) async {
    vattam = true;
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=1c8ebe33bcbcb6803d2787b2c55b1d6d&units=metric'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      smo = Smodel.fromjson(data);
      vattam = false;
      notifyListeners();
    } else {
      vattam = false;
      //throw Exception('Failed to load user');
    }
  }

  Future<Position> determinePosition() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          vattam = false;
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        vattam = false;
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } on LocationServiceDisabledException catch (e) {
      print('$e');
      vattam = false;
      return Future.error('Location  permissions$e.');
    }
  }

  Future<void> fetchCurrentWeather() async {
    vattam = true;
    notifyListeners();
    Position position = await determinePosition();

    double? latitude = position.latitude;
    double? longitude = position.longitude;

    final response = await http.get(
      Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiID&units=metric',
      ),
    );
    if (response.statusCode == 200) {
      final jsonWeatherData = await json.decode(response.body);
      Smodel? d = Smodel.fromjson(jsonWeatherData);
      smo = d;

      vattam = false;
      notifyListeners();
    } else {
      print('Failed to fetch weather data');
      vattam = false;
      notifyListeners();
    }
    notifyListeners();
  }
}

class SView extends StatelessWidget {
  const SView({super.key});

  @override
  Widget build(BuildContext context) {
    final bh = Provider.of<SProvider>(context);
    return Scaffold(
      body: Expanded(
          child: Center(
        child: Column(
          children: [
            Text(bh.smo!.name),
            Text(bh.smo!.description),
            Text('${bh.smo!.temperature}')
          ],
        ),
      )),
    );
  }
}
