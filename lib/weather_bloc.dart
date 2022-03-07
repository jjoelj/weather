import 'package:get/get_rx/src/rx_types/rx_types.dart';

class WeatherBloc {
  static RxInt selectedIndex = 0.obs;
  static RxBool useFarenheit = false.obs;
  static RxBool error = false.obs;
  static RxBool loading = false.obs;
}
