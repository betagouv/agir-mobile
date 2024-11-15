import 'package:app/features/theme/core/domain/content_id.dart';
import 'package:app/features/theme/core/domain/mission.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ThemePort {
  Future<Either<Exception, List<MissionListe>>> recupererMissions(
    final String themeType,
  );

  Future<Either<Exception, List<ServiceItem>>> getServices(
    final String themeType,
  );

  Future<Either<Exception, Mission>> recupererMission({
    required final String missionId,
  });

  Future<Either<Exception, void>> gagnerPoints({
    required final ObjectifId id,
  });

  Future<Either<Exception, void>> terminer({
    required final String missionId,
  });
}
