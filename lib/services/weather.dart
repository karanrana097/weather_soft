import 'package:weather_soft/services/location.dart';
import 'package:weather_soft/services/networking.dart';

const apiKey = '16514699aee9a94b5e2b9008158586f1';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName)async{
    String baseUrl = 'api.openweathermap.org';
    Map<String, String> queryParameters = {
      'q': cityName,
      'appid': apiKey,
      'units': 'metric',
    };
    var url = Uri.https(baseUrl, '/data/2.5/weather', queryParameters);
    NetworkHelper networkHelper= NetworkHelper(url);
    var weatherData  = await networkHelper.getData();
    return weatherData;

  }


  Future<dynamic> getLocationWeather()async{
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
    return weatherData;

  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
