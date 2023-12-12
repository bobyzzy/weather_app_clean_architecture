import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/entities/daily_weather_entity.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/repositories/weather_repository.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/usecases/get_current_weather_usecase.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late GetCurrentWeather usecase;
  late MockWeatherRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockRepository);
  });

  final tLat = 37.7749;
  final tLon = -122.4194;

  final tDailyWeatherEntity = DailyWeatherEntity(
    weather: [
      CurrentWeatherEntity(id: 800, main: 'Clear', description: 'clear sky', icon: '01d'),
    ],
    main: DailyMainEntity(
      temp: 293.52,
      feelsLike: 294.26,
      tempMin: 291.59,
      tempMax: 295.41,
      humidity: 74,
    ),
    wind: DailyWindEntity(speed: 1.5, deg: 350),
    clouds: DailyCloudsEntity(all: 1),
    dt: 1636761582,
    sys: DailySysEntity(country: 'US', sunrise: 1636723127, sunset: 1636762002),
    name: 'San Francisco',
  );

  test('should get daily weather from the repository', () async {
    // Arrange
    when(mockRepository.getDailyWeather(tLat, tLon))
        .thenAnswer((_) async => Right(tDailyWeatherEntity));

    // Act
    final result = await usecase.execute(lat: tLat, lon: tLon);

    // Assert
    print(result.fold(
      (failure) => 'Left($failure)',
      (entity) => 'Right($entity)',
    ));
    expect(result, Right(tDailyWeatherEntity));
    verify(mockRepository.getDailyWeather(tLat, tLon)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
