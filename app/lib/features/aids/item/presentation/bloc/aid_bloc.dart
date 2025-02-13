import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_event.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_state.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AidBloc extends Bloc<AidEvent, AidState> {
  AidBloc()
    : super(
        const AidState(
          Aid(themeType: ThemeType.decouverte, title: '', content: ''),
        ),
      ) {
    on<AidSelected>((final event, final emit) => emit(AidState(event.value)));
  }
}
