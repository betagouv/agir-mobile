import 'package:app/features/recommandations/domain/recommandations_port.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_event.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class RecommandationsBloc
    extends Bloc<RecommandationsEvent, RecommandationsState> {
  RecommandationsBloc({required final RecommandationsPort recommandationsPort})
      : super(const RecommandationsState.empty()) {
    on<RecommandationsRecuperationDemandee>((final event, final emit) async {
      final result = await recommandationsPort.recuperer(event.thematique);
      if (result.isRight()) {
        final recommandations =
            result.getRight().getOrElse(() => throw Exception());

        emit(RecommandationsState(recommandations: recommandations));
      }
    });
  }
}
