import 'package:equatable/equatable.dart';

sealed class MissionHomeEvent extends Equatable {
  const MissionHomeEvent();

  @override
  List<Object> get props => [];
}

final class MissionHomeFetch extends MissionHomeEvent {
  const MissionHomeFetch();
}
