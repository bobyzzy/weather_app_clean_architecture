import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:waether_app_using_api_openweather/core/constants/app_dimens.dart';
import 'package:waether_app_using_api_openweather/core/constants/constants.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/entities/daily_weather_entity.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final DailyWeatherEntity weather;
  CurrentWeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Text(
              "Current Location".tr(),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: AppDimens.MARGIN_6),
            Text(weather.name),
            SizedBox(height: 10),
            Text('${weather.main.temp.toInt()}' + "Temperature".tr(),
                style: TextStyle(fontSize: 32)),
            SizedBox(height: 5),
            Text(weather.weather.first.description),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Max".tr() + ":${weather.main.tempMin.toInt()} " + "Temperature".tr()),
                Text("Min".tr() + ":${weather.main.tempMin.toInt()} " + "Temperature".tr()),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeatherInfoCustomWidget(
                  weather: weather,
                  iconAsset: 'assets/icons/sunrise.png',
                  text: formatDate(weather.sys.sunrise),
                ),
                WeatherInfoCustomWidget(
                    weather: weather,
                    iconAsset: 'assets/icons/sunset.png',
                    text: formatDate(
                      weather.sys.sunset,
                    )),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeatherInfoCustomWidget(
                  weather: weather,
                  iconAsset: 'assets/icons/humidity.png',
                  text: '${weather.main.humidity} %',
                ),
                WeatherInfoCustomWidget(
                  weather: weather,
                  iconAsset: 'assets/icons/wind_speed.png',
                  text: '${weather.wind.speed} km',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherInfoCustomWidget extends StatelessWidget {
  const WeatherInfoCustomWidget({
    super.key,
    required this.weather,
    required this.iconAsset,
    required this.text,
  });

  final DailyWeatherEntity weather;
  final String iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Constants.LIGHT_THEME_BLUE_COLOR,
              Constants.LIGHT_THEME_MEDIUM_BLUE_COLOR,
            ],
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconAsset, scale: 5),
          SizedBox(height: 5),
          Text(text),
        ],
      ),
    );
  }
}

String formatDate(int timeStamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000, isUtc: true);
  String formatDate = DateFormat('HH:mm').format(date.toLocal());
  return formatDate;
}
