import 'package:equatable/equatable.dart';

sealed class RecommandationsEvent extends Equatable {
  const RecommandationsEvent();

  @override
  List<Object?> get props => [];
}

final class RecommandationsRecuperationDemandee extends RecommandationsEvent {
  const RecommandationsRecuperationDemandee(this.thematique);

  final String? thematique;

  @override
  List<Object?> get props => [thematique];
}
