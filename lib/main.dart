import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/daily_weather_bloc/daily_weather_cubit.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/forecast_weather_bloc/forecast_weather_cubit.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/search_weather_bloc/search_weather_cubit.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/pages/home_screen.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/theme/app_theme.dart';
import 'package:waether_app_using_api_openweather/service_locator.dart' as di;

import 'service_locator.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DailyWeatherCubit>(
            create: (context) => sl<DailyWeatherCubit>()..loadWeather()),
        BlocProvider<ForecastWeatherCubit>(
            create: (context) => sl<ForecastWeatherCubit>()..loadForecastData()),
        BlocProvider(create: (context) => sl<SearchWeatherCubit>())
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: HomeScreen(),
      ),
    );
  }
}
