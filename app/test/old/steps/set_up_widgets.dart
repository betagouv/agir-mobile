import 'package:flutter_test/flutter_test.dart';

import '../../helpers/dio_mock.dart';
import '../mocks/device_info.dart';
import 'scenario_context.dart';

void setUpWidgets(final WidgetTester tester) {
  ScenarioContext.dispose();
  ScenarioContext().dioMock = DioMock();
  DeviceInfo.setup(tester);
}
