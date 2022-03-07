import 'package:dio/dio.dart';
import 'package:weather/location.dart';
import 'package:weather/weather_bloc.dart';
import 'package:weather/weather_state.dart';

class WeatherApi {
  static const baseUrl = "https://www.metaweather.com/api/";
  static final _dio = Dio(BaseOptions(baseUrl: baseUrl));

  WeatherApi._internal();

  static final _api = WeatherApi._internal();

  factory WeatherApi() {
    return _api;
  }

  Future<Location?> queryLocation(String query) async {
    String path = "/location/search?query=$query";

    WeatherBloc.error.value = false;

    try {
      var result = await _dio.get(path);
      List data = result.data as List;

      if (data.isEmpty) return null;

      List<Location> cities = data.map((s) => Location.fromMap(s)).toList();

      return cities[0];
    } catch (e) {
      WeatherBloc.error.value = true;
      return null;
    }
  }

  Future<List<WeatherState>> getWeather(Location location) async {
    String path = "/location/${location.woeid}";

    WeatherBloc.error.value = false;
    WeatherBloc.loading.value = true;

    try {
      var result = await _dio.get(path);
      Map<String, dynamic> data = result.data;
      List forecast = data["consolidated_weather"];
      List<WeatherState> weather =
          forecast.map((f) => WeatherState.fromMap(f)).toList();

      WeatherBloc.loading.value = false;
      return weather;
    } catch (e) {
      WeatherBloc.error.value = true;
      WeatherBloc.loading.value = false;
      return [];
    }
  }
}
