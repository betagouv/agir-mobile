import 'package:equatable/equatable.dart';

class RecipeSummary extends Equatable {
  const RecipeSummary({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.difficulty,
    required this.preparationTime,
  });

  final String id;
  final String imageUrl;
  final String title;
  final String difficulty;
  final int preparationTime;

  @override
  List<Object> get props => [id, imageUrl, title, difficulty, preparationTime];
}
