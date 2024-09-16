import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/presentation/blocs/article_bloc.dart';
import 'package:app/features/articles/presentation/blocs/article_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/html_widget.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key});

  @override
  Widget build(final BuildContext context) {
    final article = context.select<ArticleBloc, Article>(
      (final v) => v.state.article,
    );

    return Scaffold(
      appBar: const FnvAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          Text(article.titre, style: const DsfrTextStyle.headline2()),
          if (article.sousTitre != null) ...[
            const SizedBox(height: DsfrSpacings.s2w),
            Text(article.sousTitre!, style: const DsfrTextStyle.headline6()),
          ],
          const SizedBox(height: DsfrSpacings.s2w),
          FnvHtmlWidget(article.contenu),
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrButton(
            label: article.isFavorite
                ? Localisation.retirerDesFavoris
                : Localisation.ajouterEnFavoris,
            icon: article.isFavorite
                ? DsfrIcons.healthHeartFill
                : DsfrIcons.healthHeartLine,
            iconLocation: DsfrButtonIconLocation.right,
            iconColor:
                article.isFavorite ? DsfrColors.redMarianneMain472 : null,
            variant: DsfrButtonVariant.tertiary,
            size: DsfrButtonSize.lg,
            onPressed: () {
              context.read<ArticleBloc>().add(
                    article.isFavorite
                        ? const ArticleRemoveToFavoritesPressed()
                        : const ArticleAddToFavoritesPressed(),
                  );
            },
          ),
          if (article.partenaire != null) ...[
            const SizedBox(height: DsfrSpacings.s4w),
            const Text(Localisation.proposePar, style: DsfrTextStyle.bodySm()),
            const SizedBox(height: DsfrSpacings.s1w),
            Image.network(
              article.partenaire!.logo,
              semanticLabel: article.partenaire!.nom,
            ),
          ],
          if (article.sources.isNotEmpty) ...[
            const SizedBox(height: DsfrSpacings.s2w),
            const Text(
              'Sources :',
              style: DsfrTextStyle.bodySm(lineHeight: 14),
            ),
            const SizedBox(height: DsfrSpacings.s1w),
            ...article.sources.map(
              (final source) => Padding(
                padding: const EdgeInsets.only(bottom: DsfrSpacings.s1w),
                child: InkWell(
                  onTap: () async => launchUrlString(source.lien),
                  child: Text.rich(
                    TextSpan(
                      text: source.libelle,
                      children: const [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            DsfrIcons.systemExternalLinkLine,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    style: const DsfrTextStyle.bodySm(lineHeight: 14).copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: DsfrSpacings.s6w),
        ],
      ),
      backgroundColor: FnvColors.aidesFond,
    );
  }
}
