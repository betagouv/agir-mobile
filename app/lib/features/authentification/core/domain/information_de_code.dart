import 'package:equatable/equatable.dart';

class InformationDeCode extends Equatable {
  const InformationDeCode({required this.adresseMail, required this.code});

  final String adresseMail;
  final String code;

  @override
  List<Object?> get props => [adresseMail, code];
}
