import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_port.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:fpdart/src/either.dart';

class ThemePortMock implements ThemePort {
  ThemePortMock({required this.missionListe});

  List<MissionListe> missionListe = [];

  @override
  Future<Either<Exception, List<MissionListe>>> getMissions(
    final ThemeType themeType,
  ) async =>
      Right(List.of(missionListe));

  @override
  Future<Either<Exception, List<ServiceItem>>> getServices(
    final ThemeType themeType,
  ) async =>
      const Right([
        ServiceItem(
          idService: 'id_service',
          titre: 'Titre',
          sousTitre: 'Sous-titre',
          externalUrl: 'https://example.com',
          iconUrl: 'https://example.com/image.jpg',
        ),
      ]);
}
