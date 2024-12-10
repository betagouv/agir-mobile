import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ThemePort {
  Future<Either<Exception, List<MissionListe>>> recupererMissions(
    final ThemeType themeType,
  );

  Future<Either<Exception, List<ServiceItem>>> getServices(
    final ThemeType themeType,
  );
}
