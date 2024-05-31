import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:equatable/equatable.dart';

final class AideState extends Equatable {
  const AideState(this.aide);

  final Aide aide;

  @override
  List<Object> get props => [aide];
}
