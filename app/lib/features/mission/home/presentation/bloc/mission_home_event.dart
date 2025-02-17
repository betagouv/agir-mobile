import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MissionHomeEvent extends Equatable {
  const MissionHomeEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class MissionHomeFetch extends MissionHomeEvent {
  const MissionHomeFetch();
}
