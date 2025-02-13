import 'package:app/features/services/lvao/domain/lvao_actor.dart';

abstract final class LvaoActorMapper {
  const LvaoActorMapper._();

  static LvaoActor fromJson(final Map<String, dynamic> json) => LvaoActor(
    name: json['titre'] as String,
    address: json['adresse_rue'] as String,
    distanceInMeters: json['distance_metres'] as int,
  );
}
