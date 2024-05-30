import 'package:equatable/equatable.dart';

final class AidesState extends Equatable {
  const AidesState({required this.aides});

  final List<AidesModel> aides;

  @override
  List<Object> get props => [aides];
}

sealed class AidesModel extends Equatable {
  const AidesModel(this.value);

  final String value;
  @override
  List<Object?> get props => [value];
}

final class AideThematiqueModel extends AidesModel {
  const AideThematiqueModel(super.value);
}

final class AideTitreModel extends AidesModel {
  const AideTitreModel(super.value);
}
