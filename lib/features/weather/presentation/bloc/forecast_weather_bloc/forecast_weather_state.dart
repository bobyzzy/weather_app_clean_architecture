// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:waether_app_using_api_openweather/features/weather/domain/entities/forecast_weather_entity.dart';

class ForecastWeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForecastWeatherEmpty extends ForecastWeatherState {}

class ForecastWeatherLoading extends ForecastWeatherState {
  @override
  List<Object?> get props => [];
}

class ForecastWeatherLoaded extends ForecastWeatherState {
  final ForecastWeatherEntity forecastWeather;

  ForecastWeatherLoaded({required this.forecastWeather});
  @override
  List<Object?> get props => [];
}

class ForecastWeatherError extends ForecastWeatherState {
  final String error;
  ForecastWeatherError({
    required this.error,
  });
  @override
  List<Object?> get props => [];
}
