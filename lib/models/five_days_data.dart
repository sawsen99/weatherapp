import 'package:weatherapp/models/weather.dart';

class FiveDayData {
  final String? dateTime;
  final List<Weather>? weather;
  final int? temp;

  FiveDayData({this.dateTime, this.temp, this.weather});

  factory FiveDayData.fromJson(dynamic json) {
    if (json == null) {
      return FiveDayData();
    }

    return FiveDayData(
      dateTime: json['dt_txt'],
      temp: (double.parse(json['main']['temp'].toString()) - 273.15).round(),
      weather:
          (json['weather'] as List).map((w) => Weather.fromJson(w)).toList(),
    );
  }
}
