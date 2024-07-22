import 'package:app/features/aides/presentation/blocs/aides/aides_bloc.dart';
import 'package:app/features/aides/presentation/blocs/aides/aides_event.dart';
import 'package:app/features/aides/presentation/blocs/aides/aides_state.dart';
import 'package:app/features/aides/presentation/widgets/carte_aide.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AidesPage extends StatelessWidget {
  const AidesPage({super.key});

  static const name = 'aides';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const AidesPage(),
      );

  @override
  Widget build(final BuildContext context) {
    final bloc = AidesBloc(aidesPort: context.read())
      ..add(const AidesRecuperationDemandee());

    return RootPage(
      body: BlocBuilder<AidesBloc, AidesState>(
        builder: (final context, final state) {
          final aides = state.aides;

          return ListView(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            children: [
              const Text(
                Localisation.vosAidesTitre,
                style: DsfrTextStyle.headline2(),
              ),
              const SizedBox(height: DsfrSpacings.s1w),
              const Text(
                Localisation.vosAidesSousTitre,
                style: DsfrTextStyle.bodyMd(),
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
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (final context, final index) =>
                    switch (aides[index]) {
                  final AideThematiqueModel a => Padding(
                      padding: const EdgeInsets.only(
                        top: DsfrSpacings.s4w,
                        bottom: DsfrSpacings.s2w,
                      ),
                      child: Text(
                        a.thematique,
                        style: const DsfrTextStyle.headline4(),
                      ),
                    ),
                  final AideModel a => CarteAide(aide: a.value),
                },
                separatorBuilder: (final context, final index) =>
                    const SizedBox(height: DsfrSpacings.s1w),
                itemCount: aides.length,
              ),
            ],
          );
        },
        bloc: bloc,
      ),
    );
  }
}
