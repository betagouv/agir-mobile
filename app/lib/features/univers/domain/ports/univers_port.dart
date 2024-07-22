import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UniversPort {
  Future<Either<Exception, List<TuileUnivers>>> recuperer();
}
