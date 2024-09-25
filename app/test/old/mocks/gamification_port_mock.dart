import 'package:app/features/gamification/domain/gamification.dart';
import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:fpdart/src/either.dart';
import 'package:rxdart/subjects.dart';

class GamificationPortMock implements GamificationPort {
  GamificationPortMock(this.value);

  Gamification value;

  final _gamificationSubject = BehaviorSubject<Gamification>();

  @override
  Future<Either<Exception, void>> mettreAJourLesPoints() {
    _gamificationSubject.add(value);

    return Future.value(const Right(null));
  }

  @override
  Stream<Gamification> gamification() => _gamificationSubject.stream;
}
