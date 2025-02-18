import 'package:equatable/equatable.dart';

class RecipeFilter extends Equatable {
  const RecipeFilter({required this.code, required this.label, required this.value});

  final String code;
  final String label;
  final bool value;

  @override
  List<Object?> get props => [code, label, value];
}
