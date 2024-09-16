import 'package:app/features/univers/domain/aggregates/mission.dart';
import 'package:app/features/univers/domain/entities/defi.dart';
import 'package:app/features/univers/domain/mission_liste.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/univers/domain/value_objects/content_id.dart';
import 'package:app/features/univers/domain/value_objects/defi_id.dart';
import 'package:app/features/univers/domain/value_objects/service_item.dart';
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

  Future<Either<Exception, Defi>> recupererDefi({
    required final DefiId defiId,
  });

  Future<Either<Exception, void>> accepterDefi({
    required final DefiId defiId,
  });

  Future<Either<Exception, void>> refuserDefi({
    required final DefiId defiId,
    final String? motif,
  });

  Future<Either<Exception, void>> realiserDefi(final DefiId defiId);

  Future<Either<Exception, void>> abondonnerDefi({
    required final DefiId defiId,
    final String? motif,
  });

  Future<Either<Exception, void>> gagnerPoints({
    required final ObjectifId id,
  });

  Future<Either<Exception, void>> terminer({
    required final String missionId,
  });
}
