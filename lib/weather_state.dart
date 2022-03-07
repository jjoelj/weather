class WeatherState {
  final String weatherStateName;
  final String weatherStateAbbr;
  final String windDirectionCompass;
  final String applicableDate;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final double windSpeed;
  final double windDirection;
  final double airPressure;
  final int humidity;
  final double visibility;
  final int predictability;

  WeatherState({
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.windDirectionCompass,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
    required this.windSpeed,
    required this.windDirection,
    required this.airPressure,
    required this.humidity,
    required this.visibility,
    required this.predictability,
  });

  factory WeatherState.fromMap(Map<String, dynamic> map) {
    return WeatherState(
      weatherStateName: map["weather_state_name"] as String,
      weatherStateAbbr: map["weather_state_abbr"] as String,
      windDirectionCompass: map["wind_direction_compass"] as String,
      applicableDate: map["applicable_date"] as String,
      minTemp: map["min_temp"] as double,
      maxTemp: map["max_temp"] as double,
      theTemp: map["the_temp"] as double,
      windSpeed: map["wind_speed"] as double,
      windDirection: map["wind_direction"] as double,
      airPressure: map["air_pressure"] as double,
      humidity: map["humidity"] as int,
      visibility: map["visibility"] as double,
      predictability: map["predictability"] as int,
    );
  }
}
