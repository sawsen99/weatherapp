import 'package:weatherapp/data/services/service.dart';
import 'package:weatherapp/models/current_weather_data.dart';
import 'package:weatherapp/models/five_days_data.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  String? city;
  String? searchText;

  bool is_loading = true;

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  List<CurrentWeatherData> dataList = [];
  List<FiveDayData> fiveDaysData = [];

  HomeController({required this.city});

  @override
  void onInit() {
    initState();
    getTopFiveCities();
    super.onInit();
  }

  void updateWeather() {
    initState();
  }

  void initState() {
    getCurrentWeatherData();
    getFiveDaysData();
  }

  void getCurrentWeatherData() {
    WeatherService(city: '$city').getCurrentWeatherData(
        onSuccess: (data) {
          is_loading = true;
          currentWeatherData = data;

          is_loading = false;
          update();
        },
        onError: (error) => {
              is_loading = true,
              print(error),
              is_loading = false,
              update(),
            });
  }

  void getTopFiveCities() {
    List<String> cities = [
      'zagazig',
      'cairo',
      'alexandria',
      'ismailia',
      'fayoum'
    ];
    cities.forEach((c) {
      WeatherService(city: '$c').getCurrentWeatherData(onSuccess: (data) {
        dataList.add(data);
        update();
      }, onError: (error) {
        print(error);
        update();
      });
    });
  }

  void getFiveDaysData() {
    WeatherService(city: '$city').getFiveDaysThreeHoursForcastData(
        onSuccess: (data) {
      fiveDaysData = data;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }
}
