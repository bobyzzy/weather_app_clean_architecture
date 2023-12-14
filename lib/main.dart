import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  await EasyLocalization.ensureInitialized();
  await di.init();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ru', "RU")],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final locale = EasyLocalization.of(context)?.locale.languageCode;
    return MultiBlocProvider(
      providers: [
        BlocProvider<DailyWeatherCubit>(
            create: (context) => sl<DailyWeatherCubit>()..loadWeather(locale)),
        BlocProvider<ForecastWeatherCubit>(
            create: (context) => sl<ForecastWeatherCubit>()..loadForecastData(locale)),
        BlocProvider(create: (context) => sl<SearchWeatherCubit>())
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: HomeScreen(),
      ),
    );
  }
}
