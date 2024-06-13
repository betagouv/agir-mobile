import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:app/features/aides/domain/ports/aides_port.dart';

class AidesPortMock implements AidesPort {
  AidesPortMock(this.aides);

  List<Aide> aides;

  @override
  Future<List<Aide>> recupereLesAides() async => aides;
}
