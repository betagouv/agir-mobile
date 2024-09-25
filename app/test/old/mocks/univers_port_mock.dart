import 'package:app/features/univers/core/domain/content_id.dart';
import 'package:app/features/univers/core/domain/defi.dart';
import 'package:app/features/univers/core/domain/defi_id.dart';
import 'package:app/features/univers/core/domain/mission.dart';
import 'package:app/features/univers/core/domain/mission_liste.dart';
import 'package:app/features/univers/core/domain/service_item.dart';
import 'package:app/features/univers/core/domain/tuile_univers.dart';
import 'package:app/features/univers/core/domain/univers_port.dart';
import 'package:fpdart/src/either.dart';

class UniversPortMock implements UniversPort {
  UniversPortMock({
    required this.univers,
    required this.missionListe,
    required this.mission,
    required this.defi,
  });

  List<TuileUnivers> univers;
  List<MissionListe> missionListe = [];
  Mission mission;
  Defi defi;

  bool accepterDefiAppele = false;
  bool refuserDefiAppele = false;
  bool realiserDefiAppele = false;
  bool abondonnerDefiAppele = false;

  @override
  Future<Either<Exception, List<TuileUnivers>>> recuperer() async =>
      Right(univers);

  @override
  Future<Either<Exception, List<MissionListe>>> recupererThematiques(
    final String universType,
  ) async =>
      Right(missionListe);

  @override
  Future<Either<Exception, Mission>> recupererMission({
    required final String missionId,
  }) async =>
      Right(mission);

  @override
  Future<Either<Exception, Defi>> recupererDefi({
    required final DefiId defiId,
  }) async =>
      Right(defi);

  @override
  Future<Either<Exception, void>> accepterDefi({
    required final DefiId defiId,
  }) async {
    accepterDefiAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> refuserDefi({
    required final DefiId defiId,
    final String? motif,
  }) async {
    refuserDefiAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> realiserDefi(final DefiId defiId) async {
    realiserDefiAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> abondonnerDefi({
    required final DefiId defiId,
    final String? motif,
  }) async {
    abondonnerDefiAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> gagnerPoints({
    required final ObjectifId id,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, void>> terminer({required final String missionId}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, List<ServiceItem>>> getServices(
    final String universType,
  ) async =>
      const Right([
        ServiceItem(
          titre: 'Titre',
          sousTitre: 'Sous-titre',
          externalUrl: 'https://example.com/image.jpg',
        ),
      ]);
}
