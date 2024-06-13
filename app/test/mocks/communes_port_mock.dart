import 'package:app/features/communes/domain/ports/communes_port.dart';

class CommunesPortMock implements CommunesPort {
  const CommunesPortMock(this.communes);

  final List<String> communes;

  @override
  Future<List<String>> recupererLesCommunes(final String codePostal) async =>
      communes;
}
