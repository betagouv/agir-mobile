import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:equatable/equatable.dart';

sealed class RecommandationsEvent extends Equatable {
  const RecommandationsEvent();

  @override
  List<Object?> get props => [];
}

final class RecommandationsRecuperationDemandee extends RecommandationsEvent {
  const RecommandationsRecuperationDemandee(this.thematique);

  final Thematique? thematique;

  @override
  List<Object?> get props => [thematique];
}
