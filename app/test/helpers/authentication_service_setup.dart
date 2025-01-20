import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:clock/clock.dart';

import '../old/api/flutter_secure_storage_fake.dart';

final authenticationService = AuthenticationService(
  authenticationRepository: AuthenticationStorage(FlutterSecureStorageFake()),
  clock: Clock.fixed(DateTime(1992)),
);
