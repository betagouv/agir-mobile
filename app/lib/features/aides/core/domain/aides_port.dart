import 'package:app/features/aides/core/domain/aide.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AidesPort {
  Future<Either<Exception, AssistanceList>> fetchAides();
}
