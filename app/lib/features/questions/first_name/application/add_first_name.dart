import 'package:app/features/questions/first_name/domain/first_name.dart';
import 'package:app/features/questions/first_name/domain/first_name_port.dart';
import 'package:fpdart/fpdart.dart';

class AddFirstName {
  const AddFirstName(this._firstNamePort);

  final FirstNamePort _firstNamePort;

  Future<Either<Exception, Unit>> call(final FirstName firstName) async =>
      _firstNamePort.addFirstName(firstName);
}
