import 'package:fpdart/fpdart.dart';

abstract interface class CommunesPort {
  Future<Either<Exception, List<String>>> recupererLesCommunes(
    final String codePostal,
  );
}
