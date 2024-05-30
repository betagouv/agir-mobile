import 'package:equatable/equatable.dart';

class Aide extends Equatable {
  const Aide({required this.titre});

  final String titre;

  @override
  List<Object?> get props => [titre];
}
