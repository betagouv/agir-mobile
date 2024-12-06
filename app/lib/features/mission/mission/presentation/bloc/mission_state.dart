import 'package:app/features/mission/mission/domain/mission.dart';
import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:app/features/mission/mission/domain/mission_objectif.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class MissionState extends Equatable {
  const MissionState();

  @override
  List<Object> get props => [];
}

@immutable
final class MissionInitial extends MissionState {
  const MissionInitial();
}

@immutable
final class MissionLoading extends MissionState {
  const MissionLoading();
}

@immutable
final class MissionSuccess extends MissionState {
  MissionSuccess({required final Mission mission, required this.index})
      : code = mission.code,
        steps = [
          MissionStepIntroduction(
            themeType: mission.themeType,
            title: mission.title,
            imageUrl: mission.imageUrl,
            description: mission.description,
          ),
          ...mission.objectifs.map(MissionStepObjectif.new),
          const MissionStepActions(),
          MissionStepFin(title: mission.title),
        ];

  const MissionSuccess._({
    required this.code,
    required this.index,
    required this.steps,
  });

  final MissionCode code;
  final int index;
  final List<MissionStep> steps;

  MissionSuccess previous() => copyWith(index: index - 1);
  MissionSuccess next() {
    if (index != 0) {
      return copyWith(index: index + 1);
    }

    final firstPendingIndex = steps.indexWhere(
      (final e) => e is MissionStepObjectif && !e.objectif.estFait,
    );

    return firstPendingIndex == -1
        ? copyWith(index: steps.length - 2)
        : copyWith(index: firstPendingIndex);
  }

  MissionSuccess copyWith({
    final MissionCode? code,
    final int? index,
    final List<MissionStep>? steps,
  }) =>
      MissionSuccess._(
        code: code ?? this.code,
        index: index ?? this.index,
        steps: steps ?? this.steps,
      );

  @override
  List<Object> get props => [index, steps, code];
}

@immutable
final class MissionFailure extends MissionState {
  const MissionFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

sealed class MissionStep extends Equatable {
  const MissionStep();

  @override
  List<Object?> get props => [];
}

final class MissionStepIntroduction extends MissionStep {
  const MissionStepIntroduction({
    required this.themeType,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  final ThemeType themeType;
  final String title;
  final String imageUrl;
  final String? description;

  @override
  List<Object?> get props => [themeType, title, imageUrl, description];
}

final class MissionStepObjectif extends MissionStep {
  const MissionStepObjectif(this.objectif);

  final MissionObjectif objectif;

  @override
  List<Object?> get props => [objectif];
}

final class MissionStepActions extends MissionStep {
  const MissionStepActions();
}

final class MissionStepFin extends MissionStep {
  const MissionStepFin({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];
}
