import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/features/aides/core/domain/aides_port.dart';
import 'package:fpdart/fpdart.dart';

class AidesPortMock implements AidesPort {
  AidesPortMock(this.aides);

  List<Assistance> aides;

  @override
  Future<Either<Exception, AssistanceList>> fetchAides() async =>
      Right(AssistanceList(isCovered: true, assistances: aides));
}
