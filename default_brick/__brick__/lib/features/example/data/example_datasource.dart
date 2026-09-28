import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{name.snakeCase()}}/core/app/error/failure.dart';
import 'package:{{name.snakeCase()}}/features/example/domain/models/example_model.dart';
import 'package:{{name.snakeCase()}}/features/example/domain/repositories/example_repository.dart';

final exampleDatasourceProvider = Provider<ExampleRepository>(
  (ref) => ExampleDatasource(),
);

class ExampleDatasource implements ExampleRepository {
  @override
  Future<Either<Failure, List<ExampleModel>>> getExamples() async {
    // TODO: inject ref.read(dioProvider) or ref.read(firestoreProvider)
    return const Right([]);
  }

  @override
  Future<Either<Failure, ExampleModel>> getExample({
    required String id,
  }) async {
    // TODO: implement
    return Left(Failure.custom(message: 'Not implemented'));
  }
}
