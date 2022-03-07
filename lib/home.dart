import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/location.dart';
import 'package:weather/search_widget.dart';
import 'package:weather/weather_api.dart';
import 'package:weather/weather_bloc.dart';
import 'package:weather/weather_display.dart';
import 'package:weather/weather_state.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  final Rxn<Location> _location = Rxn();
  final RxList<WeatherState> _weather = RxList();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      _location.value = await WeatherApi().queryLocation("Oslo");
      if (_location.value != null) {
        _weather.value = await WeatherApi().getWeather(_location.value!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(_location.value?.title ?? "")),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            Location? location = await Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => SearchWidget()
                opaque: false,
                barrierDismissible: true,
                transitionsBuilder: (context, animation, secondaryAnimation, widget) =>
                    ScaleTransition(
                      alignment: Alignment.topLeft,
                      scale: Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.fastOutSlowIn,
                        ),
                      ),
                      child: widget,
                    ),),
            );
            if (location == null) {
              return;
            }
            _location.value = location;
            _weather.value = await WeatherApi().getWeather(_location.value!);
            WeatherBloc.selectedIndex.value = 0;
          },
        ),
        actions: <Widget>[
          Obx(() =>
              Theme(data: Theme.of(context).copyWith(colorScheme: Theme
                  .of(context)
                  .colorScheme
                  .copyWith(primary: !WeatherBloc.useFarenheit.value ? Colors.white : Colors.grey,)),
                child: TextButton(onPressed: () {
                  WeatherBloc.useFarenheit.value = false;
                }, child: const Text("°C"),),
              ),),
          Obx(() =>
              Theme(data: Theme.of(context).copyWith(colorScheme: Theme
                  .of(context)
                  .colorScheme
                  .copyWith(primary: WeatherBloc.useFarenheit.value ? Colors.white : Colors.grey,)),
                child: TextButton(onPressed: () {
                  WeatherBloc.useFarenheit.value = true;
                }, child: const Text("°F"),
                ),),),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (_location.value != null) {
            _weather.value = await WeatherApi().getWeather(_location.value!);
          }
        },
        child: Obx(() =>
        WeatherBloc.loading.value ? Center(
          child: CircularProgressIndicator(
            value: null,
            color: Theme
                .of(context)
                .colorScheme
                .primary,
          ),
        ) : WeatherBloc.error.value
            ? Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Icon(Icons.error_outline, color: Theme
                .of(context)
                .errorColor, size: 48),
            const Text("Could not connect", textAlign: TextAlign.start,),
            ElevatedButton(onPressed: () async {
              _location.value ??= await WeatherApi().queryLocation("Oslo");
              if (_location.value != null) {
                _weather.value = await WeatherApi().getWeather(_location.value!);
              }
            }, child: const Text("Retry"),)
          ],),)
            : WeatherDisplay(weather: _weather),
        ),
      ),
    );
  }
}
