import 'package:app/features/challenges/core/domain/challenge_id.dart';
import 'package:app/features/challenges/core/domain/challenge_status.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

final class ChallengeItem extends Equatable {
  const ChallengeItem({
    required this.id,
    required this.themeType,
    required this.titre,
    required this.status,
  });

  final ChallengeId id;
  final ThemeType themeType;
  final String titre;
  final ChallengeStatus status;

  @override
  List<Object?> get props => [id, themeType, titre, status];
}
