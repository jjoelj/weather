import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weather/weather_bloc.dart';
import 'package:weather/weather_details.dart';
import 'package:weather/weather_list.dart';
import 'package:weather/weather_state.dart';

class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({Key? key, required this.weather}) : super(key: key);

  final List<WeatherState> weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child:  weather.isNotEmpty ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => WeatherDetails(
                weatherState: weather[WeatherBloc.selectedIndex.value],
                index: WeatherBloc.selectedIndex.value)
          ),
          Flexible(
            child: WeatherList(weather: weather),
          ),
        ],
      ) : const SizedBox.shrink(),
    );
  }
}
