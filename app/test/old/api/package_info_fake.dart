// ignore_for_file: avoid-unnecessary-nullable-return-type

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

@immutable
// ignore: avoid_implementing_value_types
class PackageInfoFake implements PackageInfo {
  const PackageInfoFake();

  @override
  String get appName => 'appName';

  @override
  String get buildNumber => 'buildNumber';

  @override
  String get buildSignature => 'buildSignature';

  @override
  Map<String, dynamic> get data => {};

  @override
  String? get installerStore => 'installerStore';

  @override
  String get packageName => 'packageName';

  @override
  String get version => 'version';
}
