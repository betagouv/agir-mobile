import 'package:app/features/communes/domain/communes_port.dart';
import 'package:fpdart/fpdart.dart';

class CommunesPortMock implements CommunesPort {
  const CommunesPortMock(this.communes);

  final List<String> communes;

  @override
  Future<Either<Exception, List<String>>> recupererLesCommunes(
    final String codePostal,
  ) async =>
      Right(List.of(communes));
}
