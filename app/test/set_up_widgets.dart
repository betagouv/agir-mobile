import 'package:flutter_test/flutter_test.dart';

import 'device_info.dart';
import 'scenario_context.dart';

void setUpWidgets(final WidgetTester tester) {
  ScenarioContext().dispose();
  DeviceInfo.setup(tester);
}
