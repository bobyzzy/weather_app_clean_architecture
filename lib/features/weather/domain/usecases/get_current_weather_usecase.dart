// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:waether_app_using_api_openweather/core/error/failures.dart';
import 'package:waether_app_using_api_openweather/core/usecases/usecase.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/entities/daily_weather_entity.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/repositories/weather_repository.dart';

class GetCurrentWeather extends UseCase<DailyWeatherEntity, PositionParams> {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, DailyWeatherEntity>> call(PositionParams params) async {
    return await repository.getDailyWeather(params.lat, params.lon, params.locale);
  }
}

class PositionParams extends Equatable {
  final double lat;
  final double lon;
  final String locale;

  PositionParams({required this.lat, required this.lon, required this.locale});

  @override
  List<Object?> get props => [lat, lon, locale];
}
