class WeatherApp {
  final String name;
  final String description;
  final double temp;
  final int humidity;

  WeatherApp({
    required this.name,
    required this.description,
    required this.temp,
    required this.humidity,
  });

  factory WeatherApp.fromJson(Map<String, dynamic> json) {
    return WeatherApp(
      name: json['name'] ?? "Unknown",
      description: json['weather'][0]['description'] ?? "No Description",
      temp: (json['main']['temp'] - 273.15), // Convert Kelvin to Celsius
      humidity: json['main']['humidity'] ?? 0,
    );
  }
}
