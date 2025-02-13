import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  const Recipe({required this.imageUrl, required this.title, required this.difficulty, required this.preparationTime});

  final String imageUrl;
  final String title;
  final String difficulty;
  final int preparationTime;

  @override
  List<Object> get props => [imageUrl, title, difficulty, preparationTime];
}
