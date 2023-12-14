import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waether_app_using_api_openweather/core/error/failures.dart';
import 'package:waether_app_using_api_openweather/core/platform/geolocation_info.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/usecases/get_forecast_weather_usecase.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/forecast_weather_bloc/forecast_weather_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server failure';
const CACHED_FAILURE_MESSAGE = 'Cache failure';

class ForecastWeatherCubit extends Cubit<ForecastWeatherState> {
  final GetForecastWeather getForecastWeather;
  final GeolocationImpl geolocationImpl;

  ForecastWeatherCubit({
    required this.getForecastWeather,
    required this.geolocationImpl,
  }) : super(ForecastWeatherEmpty());

  void loadForecastData(String? locale) async {
    if (state is ForecastWeatherLoading) return;

    final position = await geolocationImpl.geolocatorInfo();
    final failureOrdata = await getForecastWeather(PositionForecastParams(
        lat: position.latitude, lon: position.longitude, locale: locale ?? 'en'));
    print(failureOrdata);

    failureOrdata.fold((error) {
      emit(ForecastWeatherError(error: _failureMessage(error)));
    }, (data) {
      emit(ForecastWeatherLoaded(forecastWeather: data));
    });
  }

  String _failureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
