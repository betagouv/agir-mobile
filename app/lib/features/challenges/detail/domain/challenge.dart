import 'package:app/features/challenges/core/domain/challenge_id.dart';
import 'package:app/features/challenges/core/domain/challenge_status.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

class Challenge extends Equatable {
  const Challenge({
    required this.id,
    required this.themeType,
    required this.title,
    required this.status,
    required this.reason,
    required this.tips,
    required this.why,
  });

  final ChallengeId id;
  final ThemeType themeType;
  final String title;
  final ChallengeStatus status;
  final String? reason;
  final String tips;
  final String why;

  @override
  List<Object?> get props => [id, themeType, title, status, reason, tips, why];
}
