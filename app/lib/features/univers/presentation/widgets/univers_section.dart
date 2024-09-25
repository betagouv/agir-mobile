import 'package:app/features/univers/presentation/bloc/accueil_univers_bloc.dart';
import 'package:app/features/univers/presentation/bloc/accueil_univers_event.dart';
import 'package:app/features/univers/presentation/widgets/univers_liste.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UniversSection extends StatelessWidget {
  const UniversSection({super.key});

  @override
  Widget build(final BuildContext context) {
    context
        .read<AccueilUniversBloc>()
        .add(const AccueilUniversRecuperationDemandee());

    return const _View();
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: const [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Localisation.univers, style: DsfrTextStyle.headline5()),
              SizedBox(height: DsfrSpacings.s1v5),
              Text(
                Localisation.universContenu,
                style: DsfrTextStyle.bodyMd(),
              ),
            ],
          ),
          SizedBox(height: DsfrSpacings.s2w),
          UniversListe(),
        ],
      );
}
