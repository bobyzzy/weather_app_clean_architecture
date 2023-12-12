import 'package:dartz/dartz.dart';
import 'package:waether_app_using_api_openweather/core/error/failures.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/entities/daily_weather_entity.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/repositories/weather_repository.dart';

class GetSearchResult {
  final WeatherRepository repository;

  GetSearchResult(this.repository);

  Future<Either<Failure, DailyWeatherEntity>> execute(String city) async {
    return await repository.searchCityWeather(city);
  }
}
