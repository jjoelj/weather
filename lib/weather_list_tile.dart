import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/helpers.dart';
import 'package:weather/weather_bloc.dart';
import 'package:weather/weather_state.dart';

class WeatherListTile extends StatelessWidget {
  const WeatherListTile({
    Key? key,
    required this.weatherState,
    required this.index,
  }) : super(key: key);

  final WeatherState weatherState;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        tileColor: WeatherBloc.selectedIndex.value == index
            ? Theme.of(context).primaryColor
            : null,
        onTap: () {
          WeatherBloc.selectedIndex.value = index;
        },
        leading: Text(
          getShortDayString(weatherState),
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              "https://www.metaweather.com/static/img/weather/png/${weatherState.weatherStateAbbr}.png",
              width: 32,
            ),
            const SizedBox(width: 32),
            SizedBox(
              width: 60,
              child: Obx(
                () => Text(
                  "${((WeatherBloc.useFarenheit.value ? 9 / 5 : 1) * weatherState.maxTemp + (WeatherBloc.useFarenheit.value ? 32 : 0)).round()}°",
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 60,
              child: Obx(
                () => Text(
                  "${((WeatherBloc.useFarenheit.value ? 9 / 5 : 1) * weatherState.minTemp + (WeatherBloc.useFarenheit.value ? 32 : 0)).round()}°",
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
