import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class UserFetchRequested extends UserEvent {
  const UserFetchRequested();
}
