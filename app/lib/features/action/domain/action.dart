import 'package:app/features/action/domain/action_service.dart';
import 'package:equatable/equatable.dart';

final class Action extends Equatable {
  const Action({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.how,
    required this.why,
    required this.services,
  });

  final String id;
  final String title;
  final String subTitle;
  final String how;
  final String why;
  final List<ActionService> services;
  ActionService get lvaoService =>
      services.firstWhere((final service) => service.id == ServiceId.lvao);
  bool get hasLvaoService =>
      services.any((final service) => service.id == ServiceId.lvao);

  @override
  List<Object?> get props =>
      [id, title, subTitle, how, why, services, hasLvaoService];
}
