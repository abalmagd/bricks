import 'package:dartz/dartz.dart';
import 'package:{{name.snakeCase()}}/core/app/error/failure.dart';
import 'package:{{name.snakeCase()}}/features/example/domain/models/example_model.dart';

abstract interface class ExampleRepository {
  Future<Either<Failure, List<ExampleModel>>> getExamples();
  Future<Either<Failure, ExampleModel>> getExample({required String id});
}
