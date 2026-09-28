import 'package:equatable/equatable.dart';

class ExampleModel extends Equatable {
  const ExampleModel({required this.id, required this.title});

  final String id;
  final String title;

  factory ExampleModel.fromJson(Map<String, dynamic> json) {
    return ExampleModel(
      id: json['id'] as String,
      title: json['title'] as String,
    );
  }

  @override
  List<Object?> get props => [id, title];
}
