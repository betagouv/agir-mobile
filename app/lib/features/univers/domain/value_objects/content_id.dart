import 'package:equatable/equatable.dart';

class ContentId extends Equatable {
  const ContentId(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class ObjectifId extends Equatable {
  const ObjectifId(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}
