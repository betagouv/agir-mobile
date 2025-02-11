import 'package:equatable/equatable.dart';

class OpenId extends Equatable {
  const OpenId({required this.code, required this.state});

  final String code;
  final String state;

  @override
  List<Object?> get props => [code, state];
}
