import 'package:app/features/aides/core/domain/aides_port.dart';
import 'package:app/features/aides/list/presentation/bloc/aides/aides_event.dart';
import 'package:app/features/aides/list/presentation/bloc/aides/aides_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class AidesBloc extends Bloc<AidesEvent, AidesState> {
  AidesBloc({required final AidesPort aidesPort})
      : super(const AidesState(isCovered: true, aides: [])) {
    on<AidesRecuperationDemandee>((final event, final emit) async {
      final result = await aidesPort.fetchAides();
      if (result.isRight()) {
        final aides = result.getRight().getOrElse(() => throw Exception());
        final themeTypes =
            aides.assistances.map((final e) => e.themeType).toSet();
        final aidesModel = <AidesModel>[];
        for (final themeType in themeTypes) {
          aidesModel.add(AideThematiqueModel(themeType.displayName));
          aides.assistances
              .where((final e) => e.themeType == themeType)
              .forEach((final e) => aidesModel.add(AideModel(e)));
        }
        emit(AidesState(isCovered: aides.isCovered, aides: aidesModel));
      }
    });
  }
}
