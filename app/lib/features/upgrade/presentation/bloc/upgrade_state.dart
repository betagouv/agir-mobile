import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class UpgradeState extends Equatable {
  const UpgradeState();

  @override
  List<Object> get props => [];
}

@immutable
final class UpgradeInitial extends UpgradeState {
  const UpgradeInitial();
}

@immutable
final class UpgradeRequired extends UpgradeState {
  const UpgradeRequired();
}
