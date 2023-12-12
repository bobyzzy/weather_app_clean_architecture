import 'package:equatable/equatable.dart';

class DailyWeatherEntity extends Equatable {
  final List<CurrentWeatherEntity> weather;
  final DailyMainEntity main;
  final DailyWindEntity wind;
  final DailyCloudsEntity clouds;
  final int dt;
  final DailySysEntity sys;
  final String name;

  DailyWeatherEntity({
    required this.weather,
    required this.main,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.name,
  });

  @override
  List<Object?> get props => [weather, main, wind, clouds, dt, sys, name];
}

class DailyCloudsEntity extends Equatable {
  final int all;

  DailyCloudsEntity({required this.all});

  @override
  List<Object?> get props => [all];
}

class DailyMainEntity extends Equatable {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;

  DailyMainEntity({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
  });

  @override
  List<Object?> get props => [temp, feelsLike, tempMin, tempMax, humidity];
}

class DailySysEntity extends Equatable {
  final String country;
  final int sunrise;
  final int sunset;

  DailySysEntity({required this.country, required this.sunrise, required this.sunset});

  @override
  List<Object?> get props => [country, sunrise, sunset];
}

class CurrentWeatherEntity extends Equatable {
  final int id;
  final String main;
  final String description;
  final String icon;

  CurrentWeatherEntity({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, main, description, icon];
}

class DailyWindEntity extends Equatable {
  final double speed;
  final int deg;

  DailyWindEntity({required this.speed, required this.deg});

  @override
  List<Object?> get props => [speed, deg];
}
