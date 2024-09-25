import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/bloc/mieux_vous_connaitre_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/bloc/mieux_vous_connaitre_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class LesCategoriesTags extends StatelessWidget {
  const LesCategoriesTags({super.key});

  @override
  Widget build(final BuildContext context) {
    final selectionnee = context.select<MieuxVousConnaitreBloc, Thematique?>(
      (final value) => value.state.thematiqueSelectionnee.getOrElse(() => null),
    );
    const s1w = DsfrSpacings.s1w;

    return Wrap(
      spacing: s1w,
      runSpacing: s1w,
      children: [
        _Tag(
          label: Localisation.lesCategoriesTout,
          thematique: null,
          thematiqueSelected: selectionnee,
        ),
        _Tag(
          label: Localisation.lesCategoriesTransport,
          thematique: Thematique.transport,
          thematiqueSelected: selectionnee,
        ),
        _Tag(
          label: Localisation.lesCategoriesLogement,
          thematique: Thematique.logement,
          thematiqueSelected: selectionnee,
        ),
        _Tag(
          label: Localisation.lesCategoriesAlimentation,
          thematique: Thematique.alimentation,
          thematiqueSelected: selectionnee,
        ),
        _Tag(
          label: Localisation.lesCategoriesConsommation,
          thematique: Thematique.consommation,
          thematiqueSelected: selectionnee,
        ),
        _Tag(
          label: Localisation.lesCategoriesClimat,
          thematique: Thematique.climat,
          thematiqueSelected: selectionnee,
        ),
        _Tag(
          label: Localisation.lesCategoriesDechet,
          thematique: Thematique.dechet,
          thematiqueSelected: selectionnee,
        ),
        _Tag(
          label: Localisation.lesCategoriesLoisir,
          thematique: Thematique.loisir,
          thematiqueSelected: selectionnee,
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.label,
    required this.thematique,
    required this.thematiqueSelected,
  });

  final String label;
  final Thematique? thematique;
  final Thematique? thematiqueSelected;

  @override
  Widget build(final BuildContext context) {
    final isSelected = thematiqueSelected == thematique;
    const blue = DsfrColors.blueFranceSun113;

    return GestureDetector(
      onTap: () => context
          .read<MieuxVousConnaitreBloc>()
          .add(MieuxVousConnaitreThematiqueSelectionnee(thematique)),
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? blue : null,
          border: const Border.fromBorderSide(BorderSide(color: blue)),
          borderRadius:
              const BorderRadius.all(Radius.circular(DsfrSpacings.s4w)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s3v),
          child: Text(
            label,
            style: DsfrTextStyle.bodySmMedium(
              color: isSelected ? Colors.white : blue,
            ),
          ),
        ),
      ),
    );
  }
}
