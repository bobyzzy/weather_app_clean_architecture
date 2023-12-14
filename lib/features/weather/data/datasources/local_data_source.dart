import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:waether_app_using_api_openweather/core/constants/constants.dart';
import 'package:waether_app_using_api_openweather/core/error/exeptions.dart';
import 'package:waether_app_using_api_openweather/features/weather/data/model/daily_weather_model.dart';
import 'package:waether_app_using_api_openweather/features/weather/data/model/forecast_weather_model.dart';

abstract class LocalDataSource {
  Future<DailyWeatherModel> getLastCurrentWeatherFromCache();
  Future<ForecastWeatherModel> getLastForecastWeatherFromCache();
  Future<int> getLastConnection();

  Future<void> currentWeatherToCache(DailyWeatherModel dailyWeather);
  Future<void> forecastWeatherToCache(ForecastWeatherModel forecastWeather);
  Future<void> LastConnectionToCache(int lastConnection);
}

class WeatherLocalDataImpl implements LocalDataSource {
  SharedPreferences sharedPreferences;

  WeatherLocalDataImpl({required this.sharedPreferences});

  @override
  Future<void> currentWeatherToCache(DailyWeatherModel dailyWeather) {
    final String jsonDailyWeather = json.encode(dailyWeather.toJson());
    sharedPreferences.setString(Constants.CACHED_DAILY_WEATHER, jsonDailyWeather);
    print('Daily weather write to cache: ${jsonDailyWeather}');

    return Future.value(jsonDailyWeather);
  }

  @override
  Future<void> forecastWeatherToCache(ForecastWeatherModel forecastWeather) {
    final String jsonForecastWeather = json.encode(forecastWeather.toJson());
    sharedPreferences.setString(Constants.CACHED_FORECAST_WEAHTER, jsonForecastWeather);
    print('Daily weather write to cache: ${forecastWeather}');
    return Future.value(jsonForecastWeather);
  }

  @override
  Future<DailyWeatherModel> getLastCurrentWeatherFromCache() {
    final jsonDailyWeather = sharedPreferences.getString(Constants.CACHED_DAILY_WEATHER);
    if (jsonDailyWeather == null || jsonDailyWeather.isEmpty) {
      throw CacheExeption();
    } else {
      return Future.value(DailyWeatherModel.fromJson(json.decode(jsonDailyWeather)));
    }
  }

  @override
  Future<ForecastWeatherModel> getLastForecastWeatherFromCache() {
    final jsonforecastWeather = sharedPreferences.getString(Constants.CACHED_FORECAST_WEAHTER);
    if (jsonforecastWeather == null || jsonforecastWeather.isEmpty) {
      throw CacheExeption();
    } else {
      return Future.value(ForecastWeatherModel.fromJson(json.decode(jsonforecastWeather)));
    }
  }
  
  @override
  Future<void> LastConnectionToCache(int lastConnection) {
    // TODO: implement LastConnectionToCache
    throw UnimplementedError();
  }
  
  @override
  Future<int> getLastConnection() {
    // TODO: implement getLastConnection
    throw UnimplementedError();
  }
}
