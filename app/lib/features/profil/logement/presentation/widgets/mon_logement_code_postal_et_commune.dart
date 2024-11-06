import 'package:app/core/helpers/text_scaler.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_bloc.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_event.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_titre_et_contenu.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonLogementCodePostalEtCommune extends StatefulWidget {
  const MonLogementCodePostalEtCommune({super.key});

  @override
  State<MonLogementCodePostalEtCommune> createState() =>
      _MonLogementCodePostalEtCommuneState();
}

class _MonLogementCodePostalEtCommuneState
    extends State<MonLogementCodePostalEtCommune> {
  late final _textEditingController = TextEditingController();

  void _handleCommune(final BuildContext context, final String? value) {
    if (value == null) {
      return;
    }
    context.read<MonLogementBloc>().add(MonLogementCommuneChange(value));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) {
    final state = context.watch<MonLogementBloc>().state;
    if (state.communes.length == 1) {
      final commune = state.communes.first;
      _textEditingController.text = commune;
    } else {
      _textEditingController.text = state.commune;
    }

    return MonLogementTitreEtContenu(
      titre: Localisation.ouHabitezVous,
      contenu: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: adjustTextSize(context, 97),
            child: DsfrInput(
              label: Localisation.codePostal,
              initialValue: state.codePostal,
              onChanged: (final value) {
                context
                    .read<MonLogementBloc>()
                    .add(MonLogementCodePostalChange(value));
                _textEditingController.clear();
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(5),
              ],
              autofillHints: const [AutofillHints.postalCode],
            ),
          ),
          const SizedBox(width: DsfrSpacings.s2w),
          Expanded(
            child: DsfrSelect<String>(
              label: Localisation.commune,
              dropdownMenuEntries: state.communes
                  .map((final e) => DropdownMenuEntry(value: e, label: e))
                  .toList(),
              onSelected: (final value) => _handleCommune(context, value),
              controller: _textEditingController,
            ),
          ),
        ],
      ),
    );
  }
}
