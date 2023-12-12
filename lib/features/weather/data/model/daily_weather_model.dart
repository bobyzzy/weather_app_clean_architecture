import 'package:waether_app_using_api_openweather/features/weather/domain/entities/daily_weather_entity.dart';

class DailyWeatherModel extends DailyWeatherEntity {
  DailyWeatherModel({
    required super.weather,
    required super.main,
    required super.wind,
    required super.clouds,
    required super.dt,
    required super.sys,
    required super.name,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) => DailyWeatherModel(
        weather: List<CurrentWeatherModel>.from(
            json["weather"].map((x) => CurrentWeatherModel.fromJson(x))),
        main: DailyMainModel.fromJson(json["main"]),
        wind: DailyWindModel.fromJson(json["wind"]),
        clouds: DailyCloudsModel.fromJson(json["clouds"]),
        dt: json["dt"],
        sys: DailySysModel.fromJson(json["sys"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "weather": weather,
        "main": main,
        "wind": wind,
        "clouds": clouds,
        "dt": dt,
        "sys": sys,
        "name": name,
      };
}

class DailyCloudsModel extends DailyCloudsEntity {
  DailyCloudsModel({required super.all});

  factory DailyCloudsModel.fromJson(Map<String, dynamic> json) =>
      DailyCloudsModel(all: json["all"]);

  Map<String, dynamic> toJson() => {"all": all};
}

class DailyMainModel extends DailyMainEntity {
  DailyMainModel({
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.humidity,
  });

  factory DailyMainModel.fromJson(Map<String, dynamic> json) => DailyMainModel(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "humidity": humidity,
      };
}

class DailySysModel extends DailySysEntity {
  DailySysModel({
    required super.country,
    required super.sunrise,
    required super.sunset,
  });

  factory DailySysModel.fromJson(Map<String, dynamic> json) => DailySysModel(
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {"country": country, "sunrise": sunrise, "sunset": sunset};
}

class CurrentWeatherModel extends CurrentWeatherEntity {
  CurrentWeatherModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) => CurrentWeatherModel(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class DailyWindModel extends DailyWindEntity {
  DailyWindModel({
    required super.speed,
    required super.deg,
  });

  factory DailyWindModel.fromJson(Map<String, dynamic> json) => DailyWindModel(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
      );

  Map<String, dynamic> toJson() => {"speed": speed, "deg": deg};
}
