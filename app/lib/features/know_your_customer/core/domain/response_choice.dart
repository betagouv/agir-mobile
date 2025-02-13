import 'package:equatable/equatable.dart';

class ResponseChoice extends Equatable {
  const ResponseChoice({required this.code, required this.label, required this.isSelected});

  final String code;
  final String label;
  final bool isSelected;

  ResponseChoice copyWith({final String? code, final String? label, final bool? isSelected}) =>
      ResponseChoice(code: code ?? this.code, label: label ?? this.label, isSelected: isSelected ?? this.isSelected);

  @override
  List<Object?> get props => [code, label, isSelected];
}
