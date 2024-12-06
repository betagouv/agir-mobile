import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class MotDePasseOublieEvent extends Equatable {
  const MotDePasseOublieEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class MotDePasseOublieEmailChange extends MotDePasseOublieEvent {
  const MotDePasseOublieEmailChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class MotDePasseOublieValider extends MotDePasseOublieEvent {
  const MotDePasseOublieValider();
}
