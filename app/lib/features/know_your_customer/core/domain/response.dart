import 'package:equatable/equatable.dart';

class Response extends Equatable {
  const Response({required this.value, this.unit});

  final String value;
  final String? unit;

  Response copyWith({final String? value, final String? unit}) =>
      Response(value: value ?? this.value, unit: unit ?? this.unit);

  @override
  List<Object?> get props => [value, unit];
}
