import 'package:bloc/bloc.dart';
import 'package:waether_app_using_api_openweather/core/error/failures.dart';
import 'package:waether_app_using_api_openweather/core/platform/geolocation_info.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/daily_weather_bloc/daily_weater_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server failure';
const CACHED_FAILURE_MESSAGE = 'Cache failure';

class DailyWeatherCubit extends Cubit<WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final GeolocationImpl geolocationImpl;

  DailyWeatherCubit({required this.getCurrentWeather, required this.geolocationImpl})
      : super(DailyWeatherEmpty());

  void loadWeather() async {
    if (state is DailyWeatherLoading) return;

    final position = await geolocationImpl.geolocatorInfo();
    final failureOrDailyWeather =
        await getCurrentWeather(PositionParams(lat: position.latitude, lon: position.longitude));
    print(failureOrDailyWeather);

    failureOrDailyWeather.fold((error) {
      emit(DailyWeatherError(message: _failureMessage(error)));
    }, (dailyWeather) {
      emit(DailyWeatherLoaded(dailyWeather));
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
