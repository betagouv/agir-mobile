import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class AidListEvent extends Equatable {
  const AidListEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class AidListFetch extends AidListEvent {
  const AidListFetch();
}

@immutable
final class AidListThemeSelected extends AidListEvent {
  const AidListThemeSelected(this.value);

  final ThemeType? value;

  @override
  List<Object?> get props => [value];
}
