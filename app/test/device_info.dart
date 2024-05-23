import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

class DeviceInfo {
  DeviceInfo({
    required this.devicePixelRatio,
    required this.height,
    required this.width,
  });

  DeviceInfo.iPhone11()
      : this(
          devicePixelRatio: 2,
          width: 414,
          height: 896,
        );

  static void setup(final WidgetTester tester) {
    final deviceWindowInfo = DeviceInfo.iPhone11();
    tester.view
      ..devicePixelRatio = deviceWindowInfo.devicePixelRatio
      ..physicalSize = deviceWindowInfo.size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
  }

  final double devicePixelRatio;
  final double height;
  final double width;

  Size get size => Size(
        devicePixelRatio * width,
        devicePixelRatio * height,
      );
}
