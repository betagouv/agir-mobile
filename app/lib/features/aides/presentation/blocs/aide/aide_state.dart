import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:equatable/equatable.dart';

final class AideState extends Equatable {
  const AideState(this.aide);

  final Aide aide;

  @override
  List<Object> get props => [aide];
}
