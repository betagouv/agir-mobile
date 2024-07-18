import 'package:app/features/bibliotheque/presentation/blocs/bibliotheque_bloc.dart';
import 'package:app/features/bibliotheque/presentation/pages/contenu.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BibliothequeView extends StatelessWidget {
  const BibliothequeView({super.key});

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<BibliothequeBloc>().state;

    final contenus = state.bibliotheque.contenus;

    const padding = DsfrSpacings.s3w;

    return CustomScrollView(
      primary: true,
      slivers: [
        const SliverPadding(padding: EdgeInsets.only(top: padding)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          sliver: SliverList.list(
            children: [
              const Text(
                Localisation.baseDeConnaissances,
                style: DsfrTextStyle.headline2(),
              ),
              const SizedBox(height: DsfrSpacings.s1w),
              Text(
                Localisation.nombreArticle(contenus.length),
                style: const DsfrTextStyle.bodyLgBold(),
              ),
              const SizedBox(height: DsfrSpacings.s2w),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          sliver: SliverList.separated(
            itemBuilder: (final context, final index) =>
                Contenu(contenu: contenus[index]),
            separatorBuilder: (final context, final index) =>
                const SizedBox(height: DsfrSpacings.s2w),
            itemCount: contenus.length,
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: padding)),
      ],
    );
  }
}
