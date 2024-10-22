import 'dart:async';

import 'package:app/core/assets/svgs.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_bloc.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_event.dart';
import 'package:app/features/bibliotheque/presentation/pages/contenu.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BibliothequeView extends StatelessWidget {
  const BibliothequeView({super.key});

  @override
  Widget build(final BuildContext context) {
    const padding = paddingVerticalPage;

    return CustomScrollView(
      primary: true,
      slivers: [
        const SliverPadding(padding: EdgeInsets.only(top: padding)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          sliver: SliverList.list(
            children: const [
              FnvTitle(
                title: Localisation.bibliotheque,
                subtitle: Localisation.bibliothequeSousTitre,
              ),
              SizedBox(height: DsfrSpacings.s3w),
              _ChampRecherche(),
              SizedBox(height: DsfrSpacings.s1w),
              _Thematiques(),
              SizedBox(height: DsfrSpacings.s1w),
              _Favorites(),
              SizedBox(height: DsfrSpacings.s1w),
              _Nombre(),
              SizedBox(height: DsfrSpacings.s2w),
            ],
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          sliver: _SliverListe(),
        ),
        const SliverSafeArea(
          sliver: SliverPadding(padding: EdgeInsets.only(bottom: padding)),
        ),
      ],
    );
  }
}

class _Favorites extends StatelessWidget {
  const _Favorites();

  @override
  Widget build(final BuildContext context) => DsfrToggle(
        label: Localisation.mesFavoris,
        value: context.select<BibliothequeBloc, bool>(
          (final value) => value.state.isFavorites,
        ),
        onChanged: (final value) => context.read<BibliothequeBloc>().add(
              BibliothequeFavorisSelectionnee(value),
            ),
      );
}

class _Thematiques extends StatelessWidget {
  const _Thematiques();

  @override
  Widget build(final BuildContext context) {
    final filtres = context.select<BibliothequeBloc, List<BibliothequeFiltre>>(
      (final value) => value.state.bibliotheque.filtres,
    );
    const s1w = DsfrSpacings.s1w;

    return Wrap(
      spacing: s1w,
      runSpacing: s1w,
      children: filtres
          .map(
            (final thematique) => _Tag(
              label: thematique.titre,
              thematique: thematique.code,
              choisi: thematique.choisi,
            ),
          )
          .toList(),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.label,
    required this.thematique,
    required this.choisi,
  });

  final String label;
  final String thematique;
  final bool choisi;

  @override
  Widget build(final BuildContext context) {
    const blue = DsfrColors.blueFranceSun113;

    return GestureDetector(
      onTap: () => context.read<BibliothequeBloc>().add(
            BibliothequeThematiqueSelectionnee(thematique),
          ),
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: choisi ? blue : null,
          border: const Border.fromBorderSide(BorderSide(color: blue)),
          borderRadius:
              const BorderRadius.all(Radius.circular(DsfrSpacings.s4w)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(paddingVerticalPage),
          child: Text(
            label,
            style: DsfrTextStyle.bodySmMedium(
              color: choisi ? Colors.white : blue,
            ),
          ),
        ),
      ),
    );
  }
}

class _ChampRecherche extends StatefulWidget {
  const _ChampRecherche();

  @override
  State<_ChampRecherche> createState() => _ChampRechercheState();
}

class _ChampRechercheState extends State<_ChampRecherche> {
  Timer? _timer;

  void _handleValueChange(final BuildContext context, final String value) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(
      const Duration(milliseconds: 500),
      () => context.read<BibliothequeBloc>().add(
            BibliothequeRechercheSaisie(value),
          ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => DsfrInput(
        label: Localisation.rechercherParTitre,
        onChanged: (final value) => _handleValueChange(context, value),
        keyboardType: TextInputType.text,
      );
}

class _Nombre extends StatelessWidget {
  const _Nombre();

  @override
  Widget build(final BuildContext context) {
    final nombreArticle = context.select<BibliothequeBloc, int>(
      (final value) => value.state.bibliotheque.contenus.length,
    );

    return Text(
      Localisation.nombreArticle(nombreArticle),
      style: const DsfrTextStyle.bodyLgBold(),
    );
  }
}

class _SliverListe extends StatelessWidget {
  const _SliverListe();

  @override
  Widget build(final BuildContext context) {
    final contenus = context.select<BibliothequeBloc, List<Recommandation>>(
      (final value) => value.state.bibliotheque.contenus,
    );

    return contenus.isEmpty
        ? SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                SvgPicture.asset(
                  AssetsSvgs.bibliothequeEmpty,
                  semanticsLabel:
                      "Illustration lorsque aucun article n'est trouvé",
                ),
                const SizedBox(height: DsfrSpacings.s2w),
                const Text(
                  Localisation.bibliothequeAucunArticle,
                  style: DsfrTextStyle.headline4(),
                ),
              ],
            ),
          )
        : SliverList.separated(
            itemBuilder: (final context, final index) =>
                Contenu(contenu: contenus[index]),
            separatorBuilder: (final context, final index) =>
                const SizedBox(height: DsfrSpacings.s2w),
            itemCount: contenus.length,
          );
  }
}
