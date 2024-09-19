import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:app/features/aides/domain/ports/aides_port.dart';
import 'package:fpdart/fpdart.dart';

class AidesPortMock implements AidesPort {
  AidesPortMock(this.aides);

  List<Aide> aides;

  @override
  Future<Either<Exception, List<Aide>>> fetchAides() async => Right(aides);
}
