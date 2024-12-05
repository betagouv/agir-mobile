import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RecommandationsPort {
  Future<Either<Exception, List<Recommandation>>> recuperer(
    final ThemeType thematique,
  );
}
