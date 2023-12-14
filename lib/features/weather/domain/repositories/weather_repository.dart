import 'package:dartz/dartz.dart';
import 'package:waether_app_using_api_openweather/core/error/failures.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/entities/daily_weather_entity.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/entities/forecast_weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, DailyWeatherEntity>> getDailyWeather(
      double lat, double lon, String locale);
  Future<Either<Failure, ForecastWeatherEntity>> getForecastWeather(
      double lat, double lon, String locale);
  Future<Either<Failure, DailyWeatherEntity>> searchCityWeather(String nameCity,String locale);
}
