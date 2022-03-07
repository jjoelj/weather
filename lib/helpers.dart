import 'package:intl/intl.dart';
import 'package:weather/weather_state.dart';

String getShortDayString(WeatherState weatherState) {
  return getDayString(weatherState).substring(0, 3);
}

String getDayString(WeatherState weatherState) {
  DateTime day = DateTime.parse(weatherState.applicableDate);

  DateFormat formatter = DateFormat("${DateFormat.WEEKDAY} ${DateFormat.ABBR_MONTH} ${DateFormat.DAY}");

  return formatter.format(day);
}
