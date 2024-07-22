import 'package:app/features/univers/domain/ports/univers_port.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:fpdart/src/either.dart';

class UniversPortMock implements UniversPort {
  UniversPortMock(this.univers);

  List<TuileUnivers> univers;

  @override
  Future<Either<Exception, List<TuileUnivers>>> recuperer() async =>
      Right(univers);
}
