class Smodel {
  final String description;
  final String name;
  final double temperature;
  final String humidity;
  final String wind;

  Smodel({
    required this.description,
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.wind,
  });

  factory Smodel.fromjson(Map<String, dynamic> json) {
    return Smodel(
      description: json["weather"][0]["description"],
      name: json["name"],
      temperature: json["main"]["temp"],
      humidity: json["main"]["humidity"].toString(),
      wind: json["wind"]["speed"].toString(),
    );
  }
}
