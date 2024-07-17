import 'package:app/features/gamification/domain/gamification.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class GamificationPort {
  Future<Either<Exception, void>> mettreAJourLesPoints();
  Stream<Gamification> gamification();
}
