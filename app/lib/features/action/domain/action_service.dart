import 'package:equatable/equatable.dart';

class ActionService extends Equatable {
  const ActionService({required this.id, required this.category});

  final ServiceId id;
  final String category;

  @override
  List<Object?> get props => [id, category];
}

enum ServiceId { lvao, recipes }
