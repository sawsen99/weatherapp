import 'package:weatherapp/data/providers/repository.dart';
import 'package:weatherapp/models/current_weather_data.dart';
import 'package:weatherapp/models/five_days_data.dart';

class WeatherService {
  final String city;

  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  String apiToken = 'appid=727f7ee1f1d6dfb899d3dc628a87b9e0';

  WeatherService({required this.city});

  void getCurrentWeatherData({
    Function()? beforSend,
    Function(CurrentWeatherData currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/weather?q=$city&lang=en&$apiToken';
    ApiRepository(
      url: '$url',
    ).get(
        beforeSend: () => {
              if (beforSend != null)
                {
                  beforSend(),
                },
            },
        onSuccess: (data) => {
              onSuccess!(CurrentWeatherData.fromJson(data)),
            },
        onError: (error) => {
              if (onError != null)
                {
                  print(error),
                  onError(error),
                }
            });
  }

  void getFiveDaysThreeHoursForcastData({
    Function()? beforSend,
    Function(List<FiveDayData> fiveDayData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/forecast?q=$city&lang=en&$apiToken';
    print(url);
    ApiRepository(
      url: '$url',
    ).get(
        beforeSend: () => {},
        onSuccess: (data) => {
              onSuccess!((data['list'] as List)
                  .map((t) => FiveDayData.fromJson(t))
                  .toList())
            },
        onError: (error) => {
              print(error),
              onError!(error),
            });
  }
}
