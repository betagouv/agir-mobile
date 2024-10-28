import 'package:equatable/equatable.dart';

class ThemeTile extends Equatable {
  const ThemeTile({
    required this.type,
    required this.title,
    required this.imageUrl,
  });

  final String type;
  final String title;
  final String imageUrl;

  @override
  List<Object?> get props => [type, title, imageUrl];
}
