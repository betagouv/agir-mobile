import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:equatable/equatable.dart';

final class AidesState extends Equatable {
  const AidesState({required this.aides});

  final List<AidesModel> aides;

  @override
  List<Object> get props => [aides];
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

  final Aide value;

  @override
  List<Object?> get props => [value];
}
