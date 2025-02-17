import 'package:app/features/aids/core/domain/aid.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class AidState extends Equatable {
  const AidState(this.aid);

  final Aid aid;

  @override
  List<Object> get props => [aid];
}
