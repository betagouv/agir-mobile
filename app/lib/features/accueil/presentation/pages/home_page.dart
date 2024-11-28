import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/core/presentation/widgets/fondamentaux/text_styles.dart';
import 'package:app/features/accueil/presentation/cubit/home_disclaimer_cubit.dart';
import 'package:app/features/accueil/presentation/cubit/home_disclaimer_state.dart';
import 'package:app/features/actions/home/presentation/widgets/actions_section.dart';
import 'package:app/features/assistances/core/presentation/widgets/assitances_section.dart';
import 'package:app/features/environmental_performance/home/presentation/widgets/environmental_performance_section.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_event.dart';
import 'package:app/features/first_name/presentation/pages/first_name_page.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/mission/home/presentation/widgets/mission_section.dart';
import 'package:app/features/survey/survey_section.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/pages/theme_page.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_bloc.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_event.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const name = 'home';
  static const path = '/';

  static GoRoute route({required final List<RouteBase> routes}) => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const HomePage(),
        routes: routes,
      );

  @override
  Widget build(final context) => const _TabPart();
}

class _TabPart extends StatelessWidget {
  const _TabPart();

  @override
  Widget build(final context) => DefaultTabController(
        length: 5,
        child: RootPage(
          title: const _AppBarTitle(),
          appBarBottom: TabBar(
            tabs: const [
              Tab(icon: Icon(DsfrIcons.buildingsHome4Line)),
              Tab(text: 'Me nourrir'),
              Tab(text: 'Me loger'),
              Tab(text: 'Me déplacer'),
              Tab(text: 'Consommer'),
            ],
            isScrollable: true,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                color: DsfrColors.blueFranceSun113,
                width: 3,
              ),
            ),
            dividerHeight: 0,
            labelStyle: const DsfrTextStyle.bodyMd(),
            labelPadding:
                const EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
            unselectedLabelStyle: const DsfrTextStyle.bodyMd(),
            tabAlignment: TabAlignment.start,
            textScaler:
                MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 2),
          ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              _Home(),
              ThemePage(themeType: ThemeType.alimentation),
              ThemePage(themeType: ThemeType.logement),
              ThemePage(themeType: ThemeType.transport),
              ThemePage(themeType: ThemeType.consommation),
            ],
          ),
        ),
      );
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(final context) {
    final state = context.watch<UtilisateurBloc>().state;

    const font = FnvTextStyles.appBarTitleStyle;

    return Text.rich(
      TextSpan(
        text: Localisation.bonjour,
        children: [
          TextSpan(
            text: Localisation.prenomExclamation(state.utilisateur.prenom),
            style: font,
          ),
        ],
      ),
      style: font.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home();

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  @override
  void initState() {
    super.initState();
    context
        .read<UtilisateurBloc>()
        .add(const UtilisateurRecuperationDemandee());
    context
        .read<EnvironmentalPerformanceBloc>()
        .add(const EnvironmentalPerformanceStarted());
  }

  @override
  Widget build(final context) =>
      BlocListener<UtilisateurBloc, UtilisateurState>(
        listener: (final context, final state) async {
          if (!state.utilisateur.estIntegrationTerminee) {
            await GoRouter.of(context).pushReplacementNamed(FirstNamePage.name);
          }
        },
        listenWhen: (final previous, final current) =>
            previous.utilisateur.estIntegrationTerminee !=
            current.utilisateur.estIntegrationTerminee,
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            _Disclaimer(),
            SizedBox(height: paddingVerticalPage),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
              child: EnvironmentalPerformanceSection(),
            ),
            SizedBox(height: DsfrSpacings.s4w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
              child: MissionSection(),
            ),
            SizedBox(height: DsfrSpacings.s4w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
              child: AssitancesSection(),
            ),
            SizedBox(height: DsfrSpacings.s4w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
              child: ActionsSection(),
            ),
            SizedBox(height: DsfrSpacings.s4w),
            SurveySection(),
          ],
        ),
      );
}

class _Disclaimer extends StatelessWidget {
  const _Disclaimer();

  @override
  Widget build(final context) =>
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
