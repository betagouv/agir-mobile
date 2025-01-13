import 'package:app/features/version/domain/version_port.dart';
import 'package:fpdart/fpdart.dart';

class VersionPortMock implements VersionPort {
  const VersionPortMock();

  @override
  Either<Exception, String> current() => const Right('1.2.3+4');
}
