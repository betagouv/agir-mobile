import 'package:app/l10n/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

const _firstNameRegex =
    r'''^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžæÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$''';

class FirstName extends Equatable {
  const FirstName._(this.value);
  const FirstName.create(final String value) : this._(value);

  final String value;

  Option<String> get validate {
    if (value.isEmpty) {
      return const Some(Localisation.firstNameEmpty);
    }

    return RegExp(_firstNameRegex).hasMatch(value) ? const None() : const Some(Localisation.firstNameInvalid);
  }

  @override
  List<Object?> get props => [value];
}
