import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:clock/clock.dart';

import '../old/mocks/flutter_secure_storage_fake.dart';

final authenticationService = AuthenticationService(
  authenticationStorage: AuthenticationStorage(FlutterSecureStorageFake()),
  clock: Clock.fixed(DateTime(1992)),
);
