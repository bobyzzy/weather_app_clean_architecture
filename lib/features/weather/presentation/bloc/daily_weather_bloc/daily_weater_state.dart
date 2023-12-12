// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:waether_app_using_api_openweather/features/weather/domain/entities/daily_weather_entity.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class DailyWeatherEmpty extends WeatherState {
  @override
  List<Object?> get props => [];
}

class DailyWeatherLoading extends WeatherState {
  final bool isFirstFetch;

  DailyWeatherLoading({this.isFirstFetch = false});

  @override
  List<Object?> get props => [];
}

class DailyWeatherLoaded extends WeatherState {
  final DailyWeatherEntity dailyWeather;

  DailyWeatherLoaded(this.dailyWeather);

  List<Object?> get props => [dailyWeather];
}

class DailyWeatherError extends WeatherState {
  final String message;

  DailyWeatherError({required this.message});

  @override
  List<Object?> get props => [];
}
