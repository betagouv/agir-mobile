import 'package:app/src/fonctionnalites/version/domain/ports/version_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionAdapter implements VersionRepository {
  const VersionAdapter({required final PackageInfo packageInfo})
      : _packageInfo = packageInfo;

  final PackageInfo _packageInfo;

  @override
  String versionDemandee() =>
      '${_packageInfo.version}+${_packageInfo.buildNumber}';
}
