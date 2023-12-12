import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/daily_weather_bloc/daily_weather_cubit.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/forecast_weather_bloc/forecast_weather_cubit.dart';
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
            create: (context) => sl<ForecastWeatherCubit>()..loadForecastData())
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










































// final String apiKey = 'e1703262eb001aa96aab869a3491d7a6';
//   String str = '';
//   String? lat;
//   String? lon;
//   String? units;
  
//   Future<Position> _determinatePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     Future<Position> geolocator;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location service are disabled');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('location permission are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition();
//   }

//   Future<String> getData() async {
//     final String url =
//         'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&lang=ru&cnt=24&appid=$apiKey';
//     final response = await http.get(Uri.parse(url));

//     final responseBody = response.body;

//     return responseBody;
//   }