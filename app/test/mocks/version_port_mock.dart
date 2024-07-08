import 'package:app/features/version/domain/ports/version_port.dart';
import 'package:fpdart/fpdart.dart';

class VersionPortMock implements VersionPort {
  const VersionPortMock();

  @override
  Either<Exception, String> versionDemandee() => Either.right('1.2.3+4');
}
