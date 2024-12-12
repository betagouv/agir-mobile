import 'package:equatable/equatable.dart';

class Source extends Equatable {
  const Source({required this.label, required this.url});

  final String label;
  final String url;

  @override
  List<Object> get props => [label, url];
}
