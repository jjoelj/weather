import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/location.dart';
import 'package:weather/weather_api.dart';
import 'package:weather/weather_bloc.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key}) : super(key: key);

  final _textController = TextEditingController();
  final RxBool _allowClose = true.obs;
  final RxBool _invalid = false.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(_allowClose.value),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text("Search for a location"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                autofocus: true,
                controller: _textController,
                onSubmitted: (value) => _query(context, value: value),
              ),
              const SizedBox(height: 5.0),
              Obx(() {
                if (_invalid.value) {
                  return Text(
                    !WeatherBloc.error.value ? "Invalid location. Try Again" : "Could not connect",
                    style: TextStyle(color: Theme.of(context).errorColor),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
          actions: [
            Obx(() => _allowClose.value
                ? TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("CLOSE"),
                  )
                : const SizedBox.shrink()),
            TextButton(
              onPressed: () async => _query(context),
              child: const Text("SEARCH"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _query(BuildContext context, {String? value}) async {
    String query = (value ?? _textController.text).trim();
    if (query == "") {
      _invalid.value = true;
      return;
    }

    _allowClose.value = false;
    _invalid.value = false;
    Location? location = await WeatherApi().queryLocation(query);
    if (location != null) {
      Navigator.of(context).pop(location);
    } else {
      _invalid.value = true;
    }
    _allowClose.value = true;
  }
}
