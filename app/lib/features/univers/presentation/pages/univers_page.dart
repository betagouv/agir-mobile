import 'package:app/features/recommandations/presentation/widgets/mes_recommandations.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/univers/presentation/blocs/univers_bloc.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UniversPage extends StatelessWidget {
  const UniversPage({super.key});

  static const name = 'univers';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => BlocProvider(
          create: (final context) =>
              UniversBloc(univers: state.extra! as TuileUnivers),
          child: const UniversPage(),
        ),
      );

  @override
  Widget build(final BuildContext context) => const Scaffold(
        appBar: FnvAppBar(),
        body: _View(),
        backgroundColor: FnvColors.aidesFond,
      );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => const _Title();
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(final BuildContext context) => ListView(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        children: const [_ImageEtTitre(), _Recommandations()],
      );
}

class _ImageEtTitre extends StatelessWidget {
  const _ImageEtTitre();

  @override
  Widget build(final BuildContext context) {
    final univers = context
        .select<UniversBloc, TuileUnivers>((final bloc) => bloc.state.univers);

    const size = 80.0;

    return Column(
      children: [
        ClipOval(
          child: Image.network(
            univers.imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: DsfrSpacings.s1w),
        Text(univers.titre, style: const DsfrTextStyle.headline2()),
        const SizedBox(height: DsfrSpacings.s6w),
      ],
    );
  }
}

class _Recommandations extends StatelessWidget {
  const _Recommandations();

  @override
  Widget build(final BuildContext context) {
    final univers = context
        .select<UniversBloc, TuileUnivers>((final bloc) => bloc.state.univers);

    return MesRecommandations(thematique: univers.type);
  }
}
