import 'package:app/features/version/domain/version_port.dart';
import 'package:fpdart/fpdart.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionAdapter implements VersionPort {
  const VersionAdapter({required final PackageInfo packageInfo})
      : _packageInfo = packageInfo;

  final PackageInfo _packageInfo;

  @override
  Either<Exception, String> versionDemandee() =>
      Right('${_packageInfo.version}+${_packageInfo.buildNumber}');
}
