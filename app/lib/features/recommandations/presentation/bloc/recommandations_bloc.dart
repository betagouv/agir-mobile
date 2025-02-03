import 'package:app/features/recommandations/infrastructure/recommandations_repository.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_event.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class RecommandationsBloc
    extends Bloc<RecommandationsEvent, RecommandationsState> {
  RecommandationsBloc({
    required final RecommandationsRepository recommandationsRepository,
  }) : super(const RecommandationsState.empty()) {
    on<RecommandationsRecuperationDemandee>((final event, final emit) async {
      final result =
          await recommandationsRepository.recuperer(event.thematique);
      if (result.isRight()) {
        final recommandations =
            result.getRight().getOrElse(() => throw Exception());

        emit(RecommandationsState(recommandations: recommandations));
      }
    });
  }
}
