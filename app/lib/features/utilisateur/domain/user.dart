import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.firstName, this.isIntegrationCompleted});

  final String firstName;
  final bool? isIntegrationCompleted;

  @override
  List<Object?> get props => [firstName, isIntegrationCompleted];
}
