import 'package:app/features/univers/core/domain/tuile_univers.dart';
import 'package:equatable/equatable.dart';

final class AccueilUniversState extends Equatable {
  const AccueilUniversState({required this.univers});

  const AccueilUniversState.empty() : this(univers: const []);

  final List<TuileUnivers> univers;

  @override
  List<Object> get props => [univers];
}
