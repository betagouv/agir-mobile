import 'package:package_info_plus/package_info_plus.dart';

class VersionRepository {
  const VersionRepository({required final PackageInfo packageInfo})
      : _packageInfo = packageInfo;

  final PackageInfo _packageInfo;

  String current() => '${_packageInfo.version}+${_packageInfo.buildNumber}';
}
