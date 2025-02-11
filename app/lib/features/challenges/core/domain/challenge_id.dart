import 'package:equatable/equatable.dart';

class ChallengeId extends Equatable {
  const ChallengeId(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}
