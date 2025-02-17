import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class RecommandationsEvent extends Equatable {
  const RecommandationsEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class RecommandationsRecuperationDemandee extends RecommandationsEvent {
  const RecommandationsRecuperationDemandee(this.thematique);

  final ThemeType thematique;

  @override
  List<Object?> get props => [thematique];
}
