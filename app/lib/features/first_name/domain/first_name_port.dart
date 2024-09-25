import 'package:app/features/first_name/domain/first_name.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class FirstNamePort {
  Future<Either<Exception, Unit>> addFirstName(final FirstName firstName);
}
