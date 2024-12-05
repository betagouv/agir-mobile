import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/domain/recommandations_port.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:fpdart/fpdart.dart';

class RecommandationsPortMock implements RecommandationsPort {
  RecommandationsPortMock(this.recommandations);

  List<Recommandation> recommandations;

  @override
  Future<Either<Exception, List<Recommandation>>> recuperer(
    final ThemeType thematique,
  ) async =>
      Right(
        List.of(recommandations)
            .where((final e) => e.thematique == thematique)
            .toList(),
      );
}
