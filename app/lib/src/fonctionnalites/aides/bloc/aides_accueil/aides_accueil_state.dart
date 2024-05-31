import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:equatable/equatable.dart';

final class AidesAccueilState extends Equatable {
  const AidesAccueilState(this.aides);

  final List<Aide> aides;

  @override
  List<Object> get props => [aides];
}
