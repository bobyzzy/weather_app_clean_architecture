import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:waether_app_using_api_openweather/core/platform/geolocation_info.dart';
import 'package:waether_app_using_api_openweather/core/platform/network_info.dart';
import 'package:waether_app_using_api_openweather/features/weather/data/datasources/local_data_source.dart';
import 'package:waether_app_using_api_openweather/features/weather/data/datasources/remote_data_source.dart';
import 'package:waether_app_using_api_openweather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/repositories/weather_repository.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/usecases/get_forecast_weather_usecase.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/daily_weather_bloc/daily_weather_cubit.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/forecast_weather_bloc/forecast_weather_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(() => DailyWeatherCubit(
        getCurrentWeather: sl<GetCurrentWeather>(),
        geolocationImpl: sl<GeolocationImpl>(),
      ));
  sl.registerFactory(() => ForecastWeatherCubit(
        getForecastWeather: sl<GetForecastWeather>(),
        geolocationImpl: sl<GeolocationImpl>(),
      ));

  //Usecases
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));
  sl.registerLazySingleton(() => GetForecastWeather(sl()));

  //Repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
        //geolocation: sl(),
      ));

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(() => WeatherLocalDataImpl(sharedPreferences: sl()));

  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<GeolocationImpl>(() => GeolocationImpl());

  //external
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Geolocator());
}
