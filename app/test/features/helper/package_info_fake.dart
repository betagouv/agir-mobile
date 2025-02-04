// ignore_for_file: avoid-unnecessary-nullable-return-type

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

@immutable
// ignore: avoid_implementing_value_types
class PackageInfoFake implements PackageInfo {
  const PackageInfoFake({required this.version, required this.buildNumber});

  @override
  String get appName => 'appName';

  @override
  final String buildNumber;

  @override
  String get buildSignature => 'buildSignature';

  @override
  Map<String, dynamic> get data => {};

  @override
  String? get installerStore => 'installerStore';

  @override
  String get packageName => 'packageName';

  @override
  final String version;

  @override
  DateTime? get installTime =>
      DateTime.fromMillisecondsSinceEpoch(1641031200000);
}
