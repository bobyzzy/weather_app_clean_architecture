import 'package:easy_localization/easy_localization.dart';
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
                child: Text("3hours Data".tr()),
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
                        Container(
                          width: 30,
                          margin: EdgeInsets.all(10),
                          child: Image.asset('assets/icons/${data[index].weather.first.icon}.png'),
                        ),
                        Text("${data[index].main.temp.toInt().toString()} " + 'Temperature'.tr()),
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
                          width: 50,
                          child: Image.asset(
                            'assets/icons/${list[index].weather.first.icon}.png',
                            scale: 15,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("${list[index].main.temp.toInt()} " + "Temperature".tr()),
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
    return "Today".tr();
  } else if (dayOfWeek.weekday == DateTime.monday) {
    return "Monday".tr();
  } else if (dayOfWeek.weekday == DateTime.tuesday) {
    return 'Tuesday'.tr();
  } else if (dayOfWeek.weekday == DateTime.wednesday) {
    return 'Wednesday'.tr();
  } else if (dayOfWeek.weekday == DateTime.thursday) {
    return 'Thursday'.tr();
  } else if (dayOfWeek.weekday == DateTime.friday) {
    return 'Friday'.tr();
  } else if (dayOfWeek.weekday == DateTime.saturday) {
    return 'Saturday'.tr();
  } else if (dayOfWeek.weekday == DateTime.sunday) {
    return 'Sunday'.tr();
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
