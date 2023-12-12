import 'package:equatable/equatable.dart';

class ForecastWeatherEntity extends Equatable {
  final List<ListElementEntity> list;
  final ForecastCityEnitity city;

  ForecastWeatherEntity({required this.list, required this.city});

  @override
  List<Object?> get props => [list, city];
}

class ForecastCityEnitity extends Equatable {
  final String name;
  final String country;
  final int sunrise;
  final int sunset;

  ForecastCityEnitity({
    required this.name,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  @override
  List<Object?> get props => [name, country, sunrise, sunset];
}

class ListElementEntity extends Equatable {
  final int dt;
  final MainClassEntity main;
  final List<WeatherEntity> weather;
  final ForecastWindEntity wind;
  final DateTime dtTxt;
  final ForecastCloudsEntity clouds;

  ListElementEntity({
    required this.dt,
    required this.main,
    required this.weather,
    required this.wind,
    required this.dtTxt,
    required this.clouds,
  });

  @override
  List<Object?> get props => [dt, main, weather, wind, dtTxt, clouds];
}

class ForecastCloudsEntity extends Equatable {
  final int all;

  ForecastCloudsEntity({required this.all});

  @override
  List<Object?> get props => [all];
}

class MainClassEntity extends Equatable {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;

  MainClassEntity({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
  });

  @override
  List<Object?> get props => [temp, feelsLike, tempMin, tempMax, humidity];
}

class WeatherEntity extends Equatable {
  final String main;
  final String description;
  final String icon;

  WeatherEntity({
    required this.main,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [main, description, icon];
}

class ForecastWindEntity extends Equatable {
  final double speed;
  final int deg;
  final double gust;

  ForecastWindEntity({required this.speed, required this.deg, required this.gust});

  @override
  List<Object?> get props => [speed, deg, gust];
}
