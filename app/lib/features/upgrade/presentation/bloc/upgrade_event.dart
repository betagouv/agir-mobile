import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class UpgradeEvent extends Equatable {
  const UpgradeEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class UpgradeRequested extends UpgradeEvent {
  const UpgradeRequested();
}
