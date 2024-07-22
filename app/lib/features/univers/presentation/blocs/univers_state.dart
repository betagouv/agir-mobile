import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:equatable/equatable.dart';

final class UniversState extends Equatable {
  const UniversState({required this.univers});

  final TuileUnivers univers;

  @override
  List<Object?> get props => [univers];
}
