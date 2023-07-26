import 'package:flutter/material.dart';
import 'package:weather_soft/screens/location_screen.dart';
import 'package:weather_soft/services/location.dart';
import 'package:weather_soft/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '16514699aee9a94b5e2b9008158586f1';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

    void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString(),
      'appid': apiKey,
      'units': 'metric',
    });
    NetworkHelper networkHelper= NetworkHelper(url);
    var weatherData= await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(
          locationWeather:weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
