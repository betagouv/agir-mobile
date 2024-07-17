import 'package:equatable/equatable.dart';

class Gamification extends Equatable {
  const Gamification({required this.points});

  final int points;

  @override
  List<Object?> get props => [points];
}
