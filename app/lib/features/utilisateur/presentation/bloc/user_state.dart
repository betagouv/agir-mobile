import 'package:app/features/utilisateur/domain/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class UserState extends Equatable {
  const UserState({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}
