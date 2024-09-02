import 'package:app/features/recommandations/domain/ports/recommandations_port.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:fpdart/fpdart.dart';

class RecommandationsPortMock implements RecommandationsPort {
  RecommandationsPortMock(this.recommandations);

  List<Recommandation> recommandations;

  @override
  Future<Either<Exception, List<Recommandation>>> recuperer(
    final String? thematique,
  ) async =>
      Right(
        recommandations
            .where(
              (final e) => thematique == null || e.thematique == thematique,
            )
            .toList(),
      );
}
