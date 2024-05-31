import 'package:app/src/design_system/composants/app_bar.dart';
import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aides/aides_bloc.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aides/aides_event.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aides/aides_state.dart';
import 'package:app/src/fonctionnalites/aides/widgets/carte_aide.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AidesPage extends StatelessWidget {
  const AidesPage({super.key});

  static const name = 'aides';
  static const path = '/$name';

  static GoRoute route() => GoRoute(
        name: name,
        path: path,
        builder: (final context, final state) => const AidesPage(),
      );

  @override
  Widget build(final BuildContext context) {
    final bloc = AidesBloc(aidesRepository: context.read())
      ..add(const AidesRecuperationDemandee());
    return Scaffold(
      appBar: const FnvAppBar(),
      backgroundColor: FnvColors.aidesFond,
      body: BlocBuilder<AidesBloc, AidesState>(
        bloc: bloc,
        builder: (final context, final state) {
          final aides = state.aides;
          return ListView(
            padding: const EdgeInsets.all(DsfrSpacings.s3w),
            children: [
              const Text(
                Localisation.vosAidesTitre,
                style: DsfrFonts.headline2,
              ),
              const SizedBox(height: DsfrSpacings.s1w),
              const Text(
                Localisation.vosAidesSousTitre,
                style: DsfrFonts.bodyMd,
              ),
              const SizedBox(height: DsfrSpacings.s3w),
              const Align(
                alignment: Alignment.centerLeft,
                child: ColoredBox(
                  color: DsfrColors.blueFranceSun113,
                  child: SizedBox(width: 30, height: 2),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: aides.length,
                itemBuilder: (final context, final index) {
                  final aide = aides[index];
                  if (aide is AideThematiqueModel) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: DsfrSpacings.s4w,
                        bottom: DsfrSpacings.s2w,
                      ),
                      child: Text(aide.thematique, style: DsfrFonts.headline4),
                    );
                  }
                  if (aide is AideModel) {
                    return CarteAide(aide: aide.value);
                  }
                  return const SizedBox.shrink();
                },
                separatorBuilder: (final context, final index) =>
                    const SizedBox(height: DsfrSpacings.s1w),
              ),
            ],
          );
        },
      ),
    );
  }
}
