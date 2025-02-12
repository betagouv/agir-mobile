import 'package:equatable/equatable.dart';

final class Action extends Equatable {
  const Action({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.how,
    required this.why,
  });

  final String id;
  final String title;
  final String subTitle;
  final String how;
  final String why;

  @override
  List<Object?> get props => [id, title, subTitle, how, why];
}
