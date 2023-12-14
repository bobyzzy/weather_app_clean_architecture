// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:waether_app_using_api_openweather/core/error/failures.dart';
import 'package:waether_app_using_api_openweather/core/usecases/usecase.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/entities/daily_weather_entity.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/repositories/weather_repository.dart';

class GetSearchResult extends UseCase<DailyWeatherEntity, SearchParams> {
  final WeatherRepository repository;

  GetSearchResult(this.repository);

  @override
  Future<Either<Failure, DailyWeatherEntity>> call(SearchParams params) async {
    return await repository.searchCityWeather(params.query, params.locale);
  }
}

class SearchParams {
  final String query;
  final String locale;

  SearchParams({required this.query, required this.locale});
}
