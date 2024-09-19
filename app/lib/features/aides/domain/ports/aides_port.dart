import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AidesPort {
  Future<Either<Exception, List<Aide>>> fetchAides();
}
