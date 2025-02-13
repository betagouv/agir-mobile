import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:app/features/mission/mission/domain/mission_objectif.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

class Mission extends Equatable {
  const Mission({
    required this.code,
    required this.themeType,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.objectifs,
    required this.canBeCompleted,
    required this.isCompleted,
  });

  final MissionCode code;
  final ThemeType themeType;
  final String title;
  final String imageUrl;
  final String? description;
  final List<MissionObjectif> objectifs;
  final bool canBeCompleted;
  final bool isCompleted;

  @override
  List<Object?> get props => [
    code,
    title,
    imageUrl,
    description,
    objectifs,
    canBeCompleted,
    isCompleted,
    themeType,
  ];
}
