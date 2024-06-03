import 'package:app/src/fonctionnalites/version/domain/ports/version_repository.dart';

class VersionRepositoryMock implements VersionRepository {
  VersionRepositoryMock();

  @override
  String versionDemandee() => '1.2.3+4';
}
