import 'package:app/features/aids/core/domain/aid.dart';
import 'package:equatable/equatable.dart';

class AidList extends Equatable {
  const AidList({required this.isCovered, required this.aids});

  final bool isCovered;
  final List<Aid> aids;

  @override
  List<Object?> get props => [isCovered, aids];
}
