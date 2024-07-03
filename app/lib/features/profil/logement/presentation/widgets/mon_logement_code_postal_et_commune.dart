import 'package:app/features/profil/logement/presentation/blocs/mon_logement_bloc.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_event.dart';
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

  void _handleCodePostal(final BuildContext context, final String value) {
    context.read<MonLogementBloc>().add(MonLogementCodePostalChange(value));
    _textEditingController.clear();
  }

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
  Widget build(final BuildContext context) {
    final state = context.watch<MonLogementBloc>().state;
    if (state.communes.length == 1) {
      final commune = state.communes.firstOrNull!;
      _textEditingController.text = commune;
      _handleCommune(context, commune);
    } else {
      _textEditingController.text = state.commune;
    }

    return MonLogementTitreEtContenu(
      titre: Localisation.ouHabitezVous,
      contenu: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.textScalerOf(context).scale(97),
            child: DsfrInput(
              label: Localisation.codePostal,
              onChanged: (final value) => _handleCodePostal(context, value),
              initialValue: state.codePostal,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(5),
              ],
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
