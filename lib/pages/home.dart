import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final WeatherServices weatherServices = WeatherServices();

  WeatherApp? weatherData;
  bool isLoading = false;
  String errorMessage = '';

  void getWeather() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final weather = await weatherServices.fetchWeather(controller.text);
      setState(() {
        weatherData = weather;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Could not fetch weather. Check city name!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Enter city name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: getWeather,
              child: isLoading ? const CircularProgressIndicator() : const Text("Get Weather"),
            ),
            const SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            if (weatherData != null)
              Column(
                children: [
                  Text(
                    weatherData!.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    weatherData!.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Temperature: ${weatherData!.temp.toStringAsFixed(1)}°C",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Humidity: ${weatherData!.humidity}%",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
