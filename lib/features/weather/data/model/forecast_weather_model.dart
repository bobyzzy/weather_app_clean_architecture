import 'package:waether_app_using_api_openweather/features/weather/domain/entities/forecast_weather_entity.dart';

class ForecastWeatherModel extends ForecastWeatherEntity {
  ForecastWeatherModel({
    required super.list,
    required super.city,
  });

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> json) => ForecastWeatherModel(
        list: List<ListElementModel>.from(json["list"].map((x) => ListElementModel.fromJson(x))),
        city: ForecastCityModel.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "list": list,
        "city": city,
      };
}

class ForecastCityModel extends ForecastCityEnitity {
  ForecastCityModel({
    required super.name,
    required super.country,
    required super.sunrise,
    required super.sunset,
  });

  factory ForecastCityModel.fromJson(Map<String, dynamic> json) => ForecastCityModel(
        name: json["name"],
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class ListElementModel extends ListElementEntity {
  ListElementModel({
    required super.dt,
    required super.main,
    required super.weather,
    required super.wind,
    required super.dtTxt,
    required super.clouds,
  });

  factory ListElementModel.fromJson(Map<String, dynamic> json) => ListElementModel(
        dt: json["dt"],
        main: MainClassModel.fromJson(json["main"]),
        weather: List<WeatherModel>.from(json["weather"].map((x) => WeatherModel.fromJson(x))),
        wind: ForecastWindModel.fromJson(json["wind"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
        clouds: ForecastCloudsModel.fromJson(json["clouds"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main,
        "weather": weather,
        "wind": wind,
        "dt_txt": dtTxt.toIso8601String(),
        "clouds": clouds,
      };
}

class ForecastCloudsModel extends ForecastCloudsEntity {
  ForecastCloudsModel({required super.all});

  factory ForecastCloudsModel.fromJson(Map<String, dynamic> json) =>
      ForecastCloudsModel(all: json["all"]);

  Map<String, dynamic> toJson() => {"all": all};
}

class MainClassModel extends MainClassEntity {
  MainClassModel({
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.humidity,
  });

  factory MainClassModel.fromJson(Map<String, dynamic> json) => MainClassModel(
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

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.main,
    required super.description,
    required super.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class ForecastWindModel extends ForecastWindEntity {
  ForecastWindModel({
    required super.speed,
    required super.deg,
    required super.gust,
  });

  factory ForecastWindModel.fromJson(Map<String, dynamic> json) => ForecastWindModel(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
        gust: json["gust"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };
}
