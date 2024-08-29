import 'package:app/features/articles/presentation/blocs/article_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/html_widget.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key});

  @override
  Widget build(final BuildContext context) {
    final article = context.watch<ArticleBloc>().state.article;

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
          if (article.partenaire != null) ...[
            const SizedBox(height: DsfrSpacings.s4w),
            const Text(Localisation.proposePar, style: DsfrTextStyle.bodySm()),
            const SizedBox(height: DsfrSpacings.s1w),
            Image.network(
              article.partenaire!.logo,
              semanticLabel: article.partenaire!.nom,
            ),
          ],
          const SizedBox(height: DsfrSpacings.s6w),
        ],
      ),
      backgroundColor: FnvColors.aidesFond,
    );
  }
}
