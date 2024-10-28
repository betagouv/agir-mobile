import 'package:equatable/equatable.dart';

sealed class UpgradeEvent extends Equatable {
  const UpgradeEvent();

  @override
  List<Object> get props => [];
}

final class UpgradeRequested extends UpgradeEvent {
  const UpgradeRequested();
}
