import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_bloc.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_event.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_state.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionIntroductionPage extends StatelessWidget {
  const MissionIntroductionPage({super.key, required this.step});

  final MissionStepIntroduction step;

  @override
  Widget build(final context) => ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ThemeTypeTag(themeType: step.themeType),
          ),
          const SizedBox(height: DsfrSpacings.s1w),
          FnvTitle(title: step.title),
          const SizedBox(height: DsfrSpacings.s3w),
          FnvImage.network(
            step.imageUrl,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).width * 190 / 328,
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          if (step.description != null) ...[
            Text(step.description!, style: const DsfrTextStyle.bodyMdBold()),
            const SizedBox(height: DsfrSpacings.s3w),
          ],
          SafeArea(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: DsfrButton(
                  label: Localisation.commencer,
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
