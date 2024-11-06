import 'package:app/features/aides/core/domain/aide.dart';
import 'package:equatable/equatable.dart';

final class AidesState extends Equatable {
  const AidesState({required this.isCovered, required this.aides});

  final bool isCovered;
  final List<AidesModel> aides;

  @override
  List<Object> get props => [isCovered, aides];
}

sealed class AidesModel extends Equatable {
  const AidesModel();

  @override
  List<Object?> get props => [];
}

final class AideThematiqueModel extends AidesModel {
  const AideThematiqueModel(this.thematique);

  final String thematique;

  @override
  List<Object?> get props => [thematique];
}

final class AideModel extends AidesModel {
  const AideModel(this.value);

  final Assistance value;

  @override
  List<Object?> get props => [value];
}
