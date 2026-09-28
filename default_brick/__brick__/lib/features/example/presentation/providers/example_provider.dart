import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{name.snakeCase()}}/core/app/utils/alerts.dart';
import 'package:{{name.snakeCase()}}/features/example/data/example_datasource.dart';
import 'package:{{name.snakeCase()}}/features/example/domain/models/example_model.dart';

final exampleProvider =
    NotifierProvider<ExampleNotifier, List<ExampleModel>>(ExampleNotifier.new);

class ExampleNotifier extends Notifier<List<ExampleModel>> with Alerts {
  @override
  List<ExampleModel> build() => [];

  Future<void> load() async {
    final result = await ref.read(exampleDatasourceProvider).getExamples();
    result.fold(
      (failure) => failure.toast(),
      (examples) => state = examples,
    );
  }
}
