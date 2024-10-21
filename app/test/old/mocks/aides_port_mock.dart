import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/features/aides/core/domain/aides_port.dart';
import 'package:fpdart/fpdart.dart';

class AidesPortMock implements AidesPort {
  AidesPortMock(this.aides);

  List<Aid> aides;

  @override
  Future<Either<Exception, Aids>> fetchAides() async =>
      Right(Aids(isCovered: true, aids: aides));
}
