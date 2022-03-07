import 'package:flutter/material.dart';
import 'package:weather/weather_list_tile.dart';
import 'package:weather/weather_state.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final List<WeatherState> weather;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 2,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => index == 0
              ? ListTile(
                  dense: true,
                  leading: const Text("Day"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      SizedBox(
                        width: 60,
                        child: Text("High"),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: 60,
                        child: Text("Low"),
                      ),
                    ],
                  ),
                )
              : WeatherListTile(weatherState: weather[index - 1], index: index - 1),
          itemCount: weather.length + 1,
        ),
      ),
    );
  }
}
