import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RecommandationsPort {
  Future<Either<Exception, List<Recommandation>>> recuperer(
    final Thematique? thematique,
  );
}
