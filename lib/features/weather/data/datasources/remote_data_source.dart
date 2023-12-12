import 'dart:convert';

import 'package:waether_app_using_api_openweather/core/constants/constants.dart';
import 'package:waether_app_using_api_openweather/core/error/exeptions.dart';
import 'package:waether_app_using_api_openweather/features/weather/data/model/daily_weather_model.dart';
import 'package:waether_app_using_api_openweather/features/weather/data/model/forecast_weather_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<DailyWeatherModel> getCurrentWeatherRemote(double lat, double lon);
  Future<ForecastWeatherModel> getForecastWeatherRemote(double lat, double lon);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});
  @override
  Future<DailyWeatherModel> getCurrentWeatherRemote(double lat, double lon) async {
    const String api = Constants.API_CLIENT;
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&lang=ru&appid=$api';
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DailyWeatherModel.fromJson(data);
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<ForecastWeatherModel> getForecastWeatherRemote(double lat, double lon) async {
    const String api = Constants.API_CLIENT;
    final String url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&lang=ru&appid=$api';

    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ForecastWeatherModel.fromJson(data);
    } else {
      throw ServerExeption();
    }
  }
}
