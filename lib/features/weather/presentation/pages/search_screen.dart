import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waether_app_using_api_openweather/core/constants/constants.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/daily_weather_bloc/daily_weather_cubit.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/search_weather_bloc/saerch_weather_state.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/search_weather_bloc/search_weather_cubit.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/widgets/daily_weather_info_widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.LIGHT_THEME_DARK_BLUE_COLOR,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.65,
          child: SearchBar(
            controller: searchController,
            hintText: 'Введите город',
            trailing: [
              IconButton(
                  onPressed: () {
                    context.read<SearchWeatherCubit>().onPressed(searchController.text);
                    searchController.clear();
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
        ),
      ),
      body: BlocBuilder<SearchWeatherCubit, SearchWeatherState>(
        builder: (context, state) {
          if (state is SearchWEatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchWeatherEmpty) {
            return Center(
              child: Text("no data"),
            );
          } else if (state is SearchWeatherLoaded) {
            return Center(
              child: CurrentWeatherWidget(weather: state.data),
            );
          } else {
            throw ArgumentError();
          }
        },
      ),
    );
  }
}
