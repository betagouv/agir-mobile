// ignore_for_file: prefer_constructors_over_static_methods, avoid-unassigned-late-fields

import '../../helpers/dio_mock.dart';
import '../../old/api/flutter_secure_storage_fake.dart';

class FeatureContext {
  FeatureContext._();

  late DioMock dioMock;
  late FlutterSecureStorageFake secureStorage;

  static FeatureContext? _instance;

  static void reset() {
    _instance = null;
  }

  static FeatureContext get instance {
    _instance ??= FeatureContext._();

    return _instance!;
  }
}
