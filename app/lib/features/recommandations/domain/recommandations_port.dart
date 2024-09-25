import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RecommandationsPort {
  Future<Either<Exception, List<Recommandation>>> recuperer(
    final String? thematique,
  );
}
