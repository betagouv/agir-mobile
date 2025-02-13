import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/html_widget.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/presentation/bloc/article_bloc.dart';
import 'package:app/features/articles/presentation/bloc/article_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key, required this.id});

  final String id;

  @override
  Widget build(final context) => BlocProvider(
    create:
        (final context) => ArticleBloc(
          articlesRepository: context.read(),
          gamificationRepository: context.read(),
        )..add(ArticleRecuperationDemandee(id)),
    child: const _Content(),
  );
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(final context) {
    final article = context.select<ArticleBloc, Article>(
      (final v) => v.state.article,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(article.titre, style: const DsfrTextStyle.headline2()),
        if (article.sousTitre != null && article.sousTitre!.isNotEmpty) ...[
          const SizedBox(height: DsfrSpacings.s2w),
          Text(article.sousTitre!, style: const DsfrTextStyle.headline6()),
        ],
        const SizedBox(height: DsfrSpacings.s2w),
        FnvHtmlWidget(article.contenu),
        const SizedBox(height: DsfrSpacings.s2w),
        DsfrButton(
          label:
              article.isFavorite
                  ? Localisation.retirerDesFavoris
                  : Localisation.ajouterEnFavoris,
          icon:
              article.isFavorite
                  ? DsfrIcons.healthHeartFill
                  : DsfrIcons.healthHeartLine,
          iconLocation: DsfrButtonIconLocation.right,
          iconColor: article.isFavorite ? DsfrColors.redMarianneMain472 : null,
          variant: DsfrButtonVariant.tertiary,
          size: DsfrButtonSize.lg,
          onPressed:
              () => context.read<ArticleBloc>().add(
                article.isFavorite
                    ? const ArticleRemoveToFavoritesPressed()
                    : const ArticleAddToFavoritesPressed(),
              ),
        ),
        if (article.partner != null) ...[
          const SizedBox(height: DsfrSpacings.s4w),
          const Text(Localisation.proposePar, style: DsfrTextStyle.bodySm()),
          const SizedBox(height: DsfrSpacings.s1w),
          _LogoWidget(article: article),
        ],
        if (article.sources.isNotEmpty) ...[
          const SizedBox(height: DsfrSpacings.s2w),
          const Text('Sources :', style: DsfrTextStyle.bodySm()),
          const SizedBox(height: DsfrSpacings.s1w),
          ...article.sources.map(
            (final source) => Padding(
              padding: const EdgeInsets.only(bottom: DsfrSpacings.s1w),
              child: InkWell(
                onTap: () async => FnvUrlLauncher.launch(source.url),
                child: Text.rich(
                  TextSpan(
                    text: source.label,
                    children: const [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(DsfrIcons.systemExternalLinkLine, size: 14),
                      ),
                    ],
                  ),
                  style: const DsfrTextStyle.bodySm().copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget({required this.article});

  final Article article;

  @override
  Widget build(final context) {
    if (article.partner == null) {
      return const SizedBox.shrink();
    }

    final partner = article.partner!;
    final logoUrl = partner.logo;
    final logoName = partner.nom;

    return FnvImage.network(logoUrl, semanticLabel: logoName);
  }
}
