import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherServices {
  final String apiKey = 'your API key from OpenWeather';

  Future<WeatherApp?> fetchWeather(String cityName) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return WeatherApp.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (e) {
      print("Error fetching weather: $e");
      return null;
    }
  }
}
