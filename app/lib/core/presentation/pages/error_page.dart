import 'dart:async';

import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/l10n/l10n.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key, required this.packageInfo});

  final PackageInfo packageInfo;

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  static final _deviceInfoPlugin = DeviceInfoPlugin();
  ({String model, String version}) _deviceData = (model: 'inconnu', version: 'inconnu');

  @override
  void initState() {
    super.initState();
    unawaited(_setDeviceData());
  }

  Future<void> _setDeviceData() async {
    try {
      final deviceData = await _getDeviceData();
      if (!mounted) {
        return;
      }
      setState(() {
        _deviceData = deviceData;
      });
    } on PlatformException {
      if (!mounted) {
        return;
      }
      setState(() {
        _deviceData = (model: 'inconnu', version: 'inconnu');
      });
    }
  }

  Future<({String model, String version})> _getDeviceData() async {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final deviceData = await _deviceInfoPlugin.androidInfo;

        return (model: deviceData.device, version: deviceData.version.sdkInt.toString());
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        final deviceData = await _deviceInfoPlugin.iosInfo;

        return (model: deviceData.name, version: deviceData.systemVersion);
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return (model: 'inconnu', version: 'inconnu');
    }
  }

  @override
  Widget build(final context) => MaterialApp(
    home: FnvScaffold(
      body: ListView(
        padding: MediaQuery.paddingOf(context).copyWith(left: DsfrSpacings.s2w, right: DsfrSpacings.s2w),
        children: [
          const SizedBox(height: DsfrSpacings.s2w),
          const Text(Localisation.erreurInattendue, style: DsfrTextStyle.headline3()),
          const SizedBox(height: DsfrSpacings.s4w),
          const Text(Localisation.erreurInattendueContent, style: DsfrTextStyle.bodyXl()),
          const SizedBox(height: DsfrSpacings.s4w),
          Text("Nom de l'application: ${widget.packageInfo.appName}", style: const DsfrTextStyle.bodyMd()),
          const SizedBox(height: DsfrSpacings.s1w),
          Text(
            "Version de l'application: ${widget.packageInfo.version}+${widget.packageInfo.buildNumber}",
            style: const DsfrTextStyle.bodyMd(),
          ),
          const SizedBox(height: DsfrSpacings.s1w),
          Text('Magasin: ${widget.packageInfo.installerStore ?? 'inconnu'}', style: const DsfrTextStyle.bodyMd()),
          const SizedBox(height: DsfrSpacings.s1w),
          Text('Modèle: ${_deviceData.model}', style: const DsfrTextStyle.bodyMd()),
          const SizedBox(height: DsfrSpacings.s1w),
          Text('Version OS: ${_deviceData.version}', style: const DsfrTextStyle.bodyMd()),
        ],
      ),
    ),
  );
}
