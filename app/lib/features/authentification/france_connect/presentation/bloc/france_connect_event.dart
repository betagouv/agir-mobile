import 'package:app/features/authentification/france_connect/domain/open_id.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class FranceConnectEvent extends Equatable {
  const FranceConnectEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class FranceConnectCallbackReceived extends FranceConnectEvent {
  const FranceConnectCallbackReceived(this.value);

  final OpenId value;

  @override
  List<Object> get props => [value];
}
