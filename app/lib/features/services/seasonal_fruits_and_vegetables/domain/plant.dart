import 'package:equatable/equatable.dart';

class Plant extends Equatable {
  const Plant({
    required this.type,
    required this.title,
    required this.carbonFootprintInKg,
    required this.imageUrl,
  });

  final PlantType type;
  final String title;
  final double carbonFootprintInKg;
  final String imageUrl;

  @override
  List<Object> get props => [type, title, carbonFootprintInKg, imageUrl];
}

enum PlantType { fruit, vegetable, both }
