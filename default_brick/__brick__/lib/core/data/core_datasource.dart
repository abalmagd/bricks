import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{name.snakeCase()}}/core/app/error/failure.dart';
import 'package:{{name.snakeCase()}}/core/data/local/local_storage.dart';
import 'package:{{name.snakeCase()}}/core/domain/repositories/core_repository.dart';
{{#use_remote}}
import 'package:{{name.snakeCase()}}/core/data/remote/dio_manager.dart';
{{/use_remote}}
{{#use_firebase}}
import 'package:{{name.snakeCase()}}/core/data/remote/firebase_manager.dart';
{{/use_firebase}}

final coreDatasourceProvider = Provider<CoreRepository>((ref) {
  return CoreDatasource(
{{#use_remote}}
    dio: ref.read(dioProvider),
{{/use_remote}}
{{#use_firebase}}
    firestore: ref.read(firestoreProvider),
{{/use_firebase}}
    storage: ref.read(storageProvider.notifier),
  );
});

class CoreDatasource implements CoreRepository {
  CoreDatasource({
{{#use_remote}}
    required this.dio,
{{/use_remote}}
{{#use_firebase}}
    required this.firestore,
{{/use_firebase}}
    required this.storage,
  });

{{#use_remote}}
  final DioClient dio;
{{/use_remote}}
{{#use_firebase}}
  final FirestoreManager firestore;
{{/use_firebase}}
  final StorageController storage;
}
