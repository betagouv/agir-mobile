import 'package:app/features/aides/core/domain/aide.dart';
import 'package:equatable/equatable.dart';

final class AidesAccueilState extends Equatable {
  const AidesAccueilState(this.aides);

  final List<Aid> aides;

  @override
  List<Object> get props => [aides];
}
