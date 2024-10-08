import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/infrastructure/authentication_repository.dart';
import 'package:clock/clock.dart';

import '../old/api/flutter_secure_storage_fake.dart';

final authenticationService = AuthenticationService(
  authenticationRepository:
      AuthenticationRepository(FlutterSecureStorageFake()),
  clock: Clock.fixed(DateTime(1992)),
);
