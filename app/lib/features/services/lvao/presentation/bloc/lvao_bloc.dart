import 'package:app/features/services/lvao/infrastructure/lvao_repository.dart';
import 'package:app/features/services/lvao/presentation/bloc/lvao_event.dart';
import 'package:app/features/services/lvao/presentation/bloc/lvao_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LvaoBloc extends Bloc<LvaoEvent, LvaoState> {
  LvaoBloc({required final LvaoRepository repository}) : super(const LvaoInitial()) {
    on<LvaoLoadRequested>((final event, final emit) async {
      emit(const LvaoLoadInProgress());
      final result = await repository.fetch(category: event.category);
      result.fold((final l) => emit(LvaoLoadFailure(errorMessage: l.toString())), (final r) => emit(LvaoLoadSuccess(actors: r)));
    });
  }
}
