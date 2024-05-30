import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/aides/domain/ports/aides_repository.dart';

class AidesRepositoryMock implements AidesRepository {
  AidesRepositoryMock(this.aides);

  List<Aide> aides;

  @override
  Future<List<Aide>> recupereLesAides() async => aides;
}
