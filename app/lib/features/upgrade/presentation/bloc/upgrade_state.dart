import 'package:equatable/equatable.dart';

sealed class UpgradeState extends Equatable {
  const UpgradeState();

  @override
  List<Object> get props => [];
}

final class UpgradeInitial extends UpgradeState {
  const UpgradeInitial();
}

final class UpgradeRequired extends UpgradeState {
  const UpgradeRequired();
}
