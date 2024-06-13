import 'package:app/features/aides/domain/entities/aide.dart';

abstract interface class AidesPort {
  Future<List<Aide>> recupereLesAides();
}
