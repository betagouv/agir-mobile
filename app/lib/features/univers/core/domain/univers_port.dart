import 'package:app/features/univers/core/domain/content_id.dart';
import 'package:app/features/univers/core/domain/mission.dart';
import 'package:app/features/univers/core/domain/mission_liste.dart';
import 'package:app/features/univers/core/domain/service_item.dart';
import 'package:app/features/univers/core/domain/tuile_univers.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UniversPort {
  Future<Either<Exception, List<TuileUnivers>>> recuperer();

  Future<Either<Exception, List<MissionListe>>> recupererThematiques(
    final String universType,
  );

  Future<Either<Exception, List<ServiceItem>>> getServices(
    final String universType,
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
