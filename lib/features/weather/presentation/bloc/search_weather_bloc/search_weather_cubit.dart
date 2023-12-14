import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waether_app_using_api_openweather/core/error/failures.dart';
import 'package:waether_app_using_api_openweather/features/weather/domain/usecases/get_search_result_usecase.dart';
import 'package:waether_app_using_api_openweather/features/weather/presentation/bloc/search_weather_bloc/saerch_weather_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server failure';
const CACHED_FAILURE_MESSAGE = 'Cache failure';

class SearchWeatherCubit extends Cubit<SearchWeatherState> {
  GetSearchResult getSearchResult;

  SearchWeatherCubit({required this.getSearchResult}) : super(SearchWeatherEmpty());

  void onPressed(String query, String? locale) async {
    final failureOrResult =
        await getSearchResult.call(SearchParams(query: query, locale: locale ?? 'en'));

    emit(SearchWEatherLoading());

    failureOrResult.fold((error) {
      emit(SearchWeatherError(error: _failureMessage(error)));
    }, (data) {
      emit(SearchWeatherLoaded(data: data));
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
