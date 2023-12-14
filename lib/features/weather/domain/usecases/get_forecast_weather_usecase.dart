// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:waether_app_using_api_openweather/core/error/failures.dart';
import 'package:waether_app_using_api_openweather/core/usecases/usecase.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/entities/forecast_weather_entity.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/repositories/weather_repository.dart';

class GetForecastWeather extends UseCase<ForecastWeatherEntity, PositionForecastParams> {
  final WeatherRepository repository;

  GetForecastWeather(this.repository);

  Future<Either<Failure, ForecastWeatherEntity>> call(PositionForecastParams params) async {
    return await repository.getForecastWeather(params.lat, params.lon, params.locale);
  }
}

class PositionForecastParams extends Equatable {
  final double lon;
  final double lat;
  final String locale;
  PositionForecastParams({
    required this.lon,
    required this.lat,
    required this.locale,
  });

  @override
  List<Object?> get props => [lat, lon, locale];
}
