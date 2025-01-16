import 'package:app/features/accueil/presentation/cubit/home_disclaimer_cubit.dart';
import 'package:app/features/accueil/presentation/cubit/home_disclaimer_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDisclaimer extends StatelessWidget {
  const HomeDisclaimer({super.key});

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<HomeDisclaimerCubit, HomeDisclaimerState>(
        builder: (final context, final state) => switch (state) {
          HomeDisclaimerVisible() => DsfrNotice(
              titre: Localisation.appEstEnConstruction,
              description: Localisation.appEstEnConstructionDescription,
              onClose: () =>
                  context.read<HomeDisclaimerCubit>().closeDisclaimer(),
            ),
          HomeDisclaimerNotVisible() => const SizedBox(),
        },
      );
}
