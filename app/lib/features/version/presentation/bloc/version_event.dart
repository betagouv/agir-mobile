import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class VersionEvent extends Equatable {
  const VersionEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class VersionFetched extends VersionEvent {
  const VersionFetched();
}
