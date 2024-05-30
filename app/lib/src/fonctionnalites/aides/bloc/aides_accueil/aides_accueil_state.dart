import 'package:equatable/equatable.dart';

final class AidesAccueilState extends Equatable {
  const AidesAccueilState(this.titres);

  final List<String> titres;

  @override
  List<Object> get props => [titres];
}
