// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:waether_app_using_api_openweather/features/weather/domain/entities/daily_weather_entity.dart';

class SearchWeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchWeatherEmpty extends SearchWeatherState {}

class SearchWEatherLoading extends SearchWeatherState {}

class SearchWeatherLoaded extends SearchWeatherState {
  final DailyWeatherEntity data;

  SearchWeatherLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class SearchWeatherError extends SearchWeatherState {
  final String error;

  SearchWeatherError({required this.error});

  @override
  List<Object?> get props => [error];
}
