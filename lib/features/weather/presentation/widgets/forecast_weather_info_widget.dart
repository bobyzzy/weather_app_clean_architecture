import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waether_app_using_api_openweather/core/constants/app_dimens.dart';
import 'package:waether_app_using_api_openweather/core/constants/constants.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/entities/forecast_weather_entity.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/forecast_weather_bloc/forecast_weather_cubit.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/forecast_weather_bloc/forecast_weather_state.dart';

class ForecastWeatherWidget extends StatelessWidget {
  const ForecastWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastWeatherCubit, ForecastWeatherState>(
      builder: (context, state) {
        if (state is ForecastWeatherLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: AppDimens.MARGIN_24),
                child: Text("Данные отображаются с интервалом 3 часа"),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: AppDimens.MARGIN_16),
                padding: EdgeInsets.all(AppDimens.MARGIN_16),
                width: MediaQuery.of(context).size.width,
                height: 130,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 2],
                    colors: [
                      Constants.LIGHT_THEME_BLUE_COLOR,
                      Constants.LIGHT_THEME_MEDIUM_BLUE_COLOR,
                    ],
                  ),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.forecastWeather.list.length,
                  itemBuilder: (context, index) {
                    var data = state.forecastWeather.list;
                    return Column(
                      children: [
                        Text(data[index].dtTxt.hour.toString()),
                        Image.network(
                          'https://openweathermap.org/img/wn/${data[index].weather.first.icon}@2x.png',
                          scale: 2,
                        ),
                        Text(data[index].main.temp.toInt().toString() + ' \u2103'),
                      ],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 2],
                    colors: [
                      Constants.LIGHT_THEME_BLUE_COLOR,
                      Constants.LIGHT_THEME_MEDIUM_BLUE_COLOR,
                    ],
                  ),
                ),
                child: ListView.separated(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: temp(state.forecastWeather).length,
                  padding: EdgeInsets.all(15),
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    var list = temp(state.forecastWeather);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          child: Text(getDayOfWeekName(list[index].dtTxt)),
                        ),
                        Container(
                          child: Image.network(
                            'https://openweathermap.org/img/wn/${list[index].weather.first.icon}@2x.png',
                            scale: 2,
                          ),
                        ),
                        Text("${list[index].main.temp.toInt()} \u2103"),
                        SizedBox(width: 40),
                        Expanded(child: Text("${list[index].weather.first.description}")),
                      ],
                    );
                  },
                ),
              )
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

String getDayOfWeekName(DateTime dayOfWeek) {
  DateTime today = DateTime.now();
  if (dayOfWeek.weekday == today.weekday) {
    return "Сегодня";
  } else if (dayOfWeek.weekday == DateTime.monday) {
    return "Понедельник";
  } else if (dayOfWeek.weekday == DateTime.tuesday) {
    return 'Вторник';
  } else if (dayOfWeek.weekday == DateTime.wednesday) {
    return 'Среда';
  } else if (dayOfWeek.weekday == DateTime.thursday) {
    return 'Четверг';
  } else if (dayOfWeek.weekday == DateTime.friday) {
    return 'Пятница';
  } else if (dayOfWeek.weekday == DateTime.saturday) {
    return 'Суббота';
  } else if (dayOfWeek.weekday == DateTime.sunday) {
    return 'Воскресенье';
  } else {
    return 'invalid type';
  }
}

List<ListElementEntity> temp(ForecastWeatherEntity data) {
  List<ListElementEntity> list = [];
  for (var i = 1; i <= 7; i++) {
    for (var k = 0; k < data.list.length; k++) {
      if (data.list[k].dtTxt.weekday == i) {
        list.add(data.list[k]);
        i++;
      }
    }
  }
  return list;
}
