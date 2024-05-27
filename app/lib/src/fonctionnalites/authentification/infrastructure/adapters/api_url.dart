import 'package:equatable/equatable.dart';

class ApiUrl extends Equatable {
  const ApiUrl(this.valeur);

  final Uri valeur;

  @override
  List<Object?> get props => [valeur];
}
