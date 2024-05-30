import 'package:app/src/fonctionnalites/aides/domain/aide.dart';

abstract interface class AidesRepository {
  Future<List<Aide>> recupereLesAides();
}
