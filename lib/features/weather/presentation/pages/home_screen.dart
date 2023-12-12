import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waether_app_using_api_openweather/core/constants/constants.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/daily_weather_bloc/daily_weater_state.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/daily_weather_bloc/daily_weather_cubit.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/widgets/daily_weather_info_widget.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/widgets/forecast_weather_info_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.LIGHT_THEME_DARK_BLUE_COLOR,
      body: BlocBuilder<DailyWeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is DailyWeatherLoaded) {
            return SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  CurrentWeatherWidget(weather: state.dailyWeather),
                  SizedBox(height: 32),
                  ForecastWeatherWidget()
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class WeatherInfoWidget extends StatelessWidget {
  const WeatherInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyWeatherCubit, WeatherState>(
      builder: (context, state) {
        return Row();
      },
    );
  }
}
