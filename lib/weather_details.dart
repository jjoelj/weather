import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/helpers.dart';
import 'package:weather/weather_bloc.dart';
import 'package:weather/weather_state.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({Key? key, required this.weatherState, required this.index}) : super(key: key);

  final WeatherState weatherState;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(getDayString(weatherState)),
                  Obx(
                    () => Text(
                      "${((WeatherBloc.useFarenheit.value ? 9 / 5 : 1) * weatherState.theTemp + (WeatherBloc.useFarenheit.value ? 32 : 0)).round()}°",
                      style: const TextStyle(
                        fontSize: 64,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text("Humidity"),
                          Text("Pressure"),
                          Text("Wind"),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${weatherState.humidity}%"),
                          Text("${weatherState.airPressure.round()} mbar"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${weatherState.windSpeed.round()} ${weatherState.windDirectionCompass}"),
                              Transform.rotate(
                                angle: weatherState.windDirection / 180 * pi,
                                child: const Icon(Icons.navigation, size: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.network(
                          "https://www.metaweather.com/static/img/weather/png/${weatherState.weatherStateAbbr}.png",
                          height: 64),
                      Padding(
                        child: Text(
                          weatherState.weatherStateName,
                          maxLines: 2,
                          style: TextStyle(fontSize: 16),
                        ),
                        padding: EdgeInsets.only(left: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
