import 'package:app/features/univers/core/domain/defi.dart';
import 'package:app/features/univers/core/domain/defi_id.dart';

abstract final class DefiMapper {
  const DefiMapper._();

  static Defi fromJson(final Map<String, dynamic> json) => Defi(
        id: DefiId(json['id'] as String),
        thematique: json['thematique_label'] as String,
        titre: json['titre'] as String,
        status: json['status'] as String? ?? 'todo',
        motif: json['motif'] as String?,
        astuces: json['astuces'] as String,
        pourquoi: json['pourquoi'] as String,
      );
}
