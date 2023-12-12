
import 'package:dartz/dartz.dart';
import 'package:waether_app_using_api_openweather/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure,Type>> call(Params params);
}
