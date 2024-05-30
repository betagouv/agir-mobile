import 'package:equatable/equatable.dart';

final class AidesState extends Equatable {
  const AidesState(this.titres);

  final List<String> titres;

  @override
  List<Object> get props => [titres];
}
