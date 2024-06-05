import 'package:equatable/equatable.dart';

class AideVeloCollectivite extends Equatable {
  const AideVeloCollectivite({required this.kind, required this.value});

  final String kind;
  final String value;

  @override
  List<Object?> get props => [kind, value];
}
