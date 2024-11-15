import 'package:equatable/equatable.dart';

class ContentId extends Equatable {
  const ContentId(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}
