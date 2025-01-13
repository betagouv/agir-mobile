import 'package:fpdart/fpdart.dart';

abstract interface class VersionPort {
  Either<Exception, String> current();
}
