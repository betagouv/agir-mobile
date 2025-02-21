import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class LogoutRequested extends LogoutEvent {
  const LogoutRequested();
}
