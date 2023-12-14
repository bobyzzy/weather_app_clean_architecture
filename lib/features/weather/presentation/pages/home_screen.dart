import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:waether_app_using_api_openweather/core/constants/constants.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/daily_weather_bloc/daily_weater_state.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/daily_weather_bloc/daily_weather_cubit.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/pages/search_screen.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/widgets/daily_weather_info_widget.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/widgets/forecast_weather_info_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //TODO:Добавить свои ассеты на погоды а то когда выключается инет приложения останавливается
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.LIGHT_THEME_DARK_BLUE_COLOR,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 35,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          ),
        ],
      ),
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
