import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class RecommandationsState extends Equatable {
  const RecommandationsState({required this.recommandations});

  const RecommandationsState.empty() : this(recommandations: const []);

  final List<Recommandation> recommandations;

  @override
  List<Object> get props => [recommandations];
}
