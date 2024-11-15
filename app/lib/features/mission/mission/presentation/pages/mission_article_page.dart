import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/articles/presentation/pages/article_view.dart';
import 'package:app/features/mission/mission/domain/mission_article.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_bloc.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionArticlePage extends StatelessWidget {
  const MissionArticlePage({super.key, required this.value});

  final MissionArticle value;

  @override
  Widget build(final context) => ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          ArticleView(id: value.contentId.value),
          const SizedBox(height: DsfrSpacings.s3w),
          SafeArea(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: DsfrButton(
                  label: Localisation.continuer,
                  variant: DsfrButtonVariant.primary,
                  size: DsfrButtonSize.lg,
                  onPressed: () => context
                      .read<MissionBloc>()
                      .add(const MissionNextRequested()),
                ),
              ),
            ),
          ),
        ],
      );
}
