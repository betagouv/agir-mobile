import 'package:app/features/version/domain/ports/version_port.dart';

class VersionPortMock implements VersionPort {
  const VersionPortMock();

  @override
  String versionDemandee() => '1.2.3+4';
}
