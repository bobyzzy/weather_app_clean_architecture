// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:waether_app_using_api_openweather/core/error/exeptions.dart';

import 'package:waether_app_using_api_openweather/core/error/failures.dart';
import 'package:waether_app_using_api_openweather/features/weather/data/datasources/local_data_source.dart';
import 'package:waether_app_using_api_openweather/features/weather/data/datasources/remote_data_source.dart';
import 'package:waether_app_using_api_openweather/features/weather/data/model/daily_weather_model.dart';
import 'package:waether_app_using_api_openweather/features/weather/data/model/forecast_weather_model.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/entities/daily_weather_entity.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/entities/forecast_weather_entity.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  InternetConnectionChecker networkInfo;
  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DailyWeatherEntity>> getDailyWeather(
      double lat, double lon, String locale) async {
    return await _getDailyWeather(() {
      return remoteDataSource.getCurrentWeatherRemote(lat, lon,locale);
    });
  }

  @override
  Future<Either<Failure, ForecastWeatherEntity>> getForecastWeather(
      double lat, double lon, String locale) async {
    return await _getForecastWeather(() {
      return remoteDataSource.getForecastWeatherRemote(lat, lon,locale);
    });
  }

  @override
  Future<Either<Failure, DailyWeatherEntity>> searchCityWeather(String nameCity,String locale) async {
    return await _getSearchData(() {
      return remoteDataSource.getSearchDataRemote(nameCity,locale);
    });
  }

  Future<Either<Failure, DailyWeatherEntity>> _getDailyWeather(
      Future<DailyWeatherModel> Function() getDailyWeather) async {
    if (await networkInfo.hasConnection) {
      try {
        final remoteDailyWeather = await getDailyWeather();
        localDataSource.currentWeatherToCache(remoteDailyWeather);
        return Right(remoteDailyWeather);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localDailyWeather = await localDataSource.getLastCurrentWeatherFromCache();
        return Right(localDailyWeather);
      } on CacheExeption {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, ForecastWeatherEntity>> _getForecastWeather(
      Future<ForecastWeatherModel> Function() getForecastWeather) async {
    if (await networkInfo.hasConnection) {
      try {
        final remoteForecastWeather = await getForecastWeather();
        localDataSource.forecastWeatherToCache(remoteForecastWeather);

        return Right(remoteForecastWeather);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localForecastWeather = await localDataSource.getLastForecastWeatherFromCache();
        return Right(localForecastWeather);
      } on CacheExeption {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, DailyWeatherEntity>> _getSearchData(
      Future<DailyWeatherEntity> Function() getSearchData) async {
    if (await networkInfo.hasConnection) {
      try {
        final remoteDailyWeather = await getSearchData();
        return Right(remoteDailyWeather);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      throw CacheFailure();
    }
  }
}
