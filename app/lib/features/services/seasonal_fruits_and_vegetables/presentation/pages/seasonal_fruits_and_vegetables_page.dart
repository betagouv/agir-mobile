import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/dropdown_button.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/partner_card.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/core/presentation/widgets/fondamentaux/tab_indicator.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/domain/plant.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/presentation/bloc/seasonal_fruits_and_vegetables_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SeasonalFruitsAndVegetablesPage extends StatelessWidget {
  const SeasonalFruitsAndVegetablesPage({super.key});

  static const name = 'fruits-et-legumes';
  static const path = name;

  static GoRoute get route =>
      GoRoute(path: path, name: name, builder: (final context, final state) => const SeasonalFruitsAndVegetablesPage());

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocProvider(
      create:
          (final context) =>
              SeasonalFruitsAndVegetablesBloc(repository: context.read())..add(const SeasonalFruitsAndVegetablesFetch()),
      child: const _Body(),
    ),
  );
}

final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<SeasonalFruitsAndVegetablesBloc>().state;

    return switch (state) {
      SeasonalFruitsAndVegetablesInitial() => const Center(child: CircularProgressIndicator()),
      final SeasonalFruitsAndVegetablesLoadSuccess s => _Success(value: s),
      final SeasonalFruitsAndVegetablesLoadFailure f => Center(
        child: Text('Erreur lors du chargement des fruits et légumes: ${f.error}', style: const TextStyle(color: Colors.red)),
      ),
    };
  }
}

class _Success extends StatelessWidget {
  const _Success({required this.value});

  final SeasonalFruitsAndVegetablesLoadSuccess value;

  @override
  Widget build(final BuildContext context) => DefaultTabController(
    length: 2,
    child: Column(
      children: [
        const SizedBox(height: DsfrSpacings.s4w),
        Padding(padding: const EdgeInsets.symmetric(horizontal: paddingVerticalPage), child: _Header(value: value)),
        const SizedBox(height: DsfrSpacings.s4w),
        const DecoratedBox(
          decoration: BoxDecoration(
            color: FnvColors.homeBackground,
            boxShadow: [BoxShadow(color: Color(0x08000068), offset: Offset(0, 5), blurRadius: 10)],
          ),
          child: TabBar(
            tabs: [Tab(text: Localisation.fruits), Tab(text: Localisation.legumes)],
            indicator: DsfrTabIndicator(borderSide: BorderSide(color: DsfrColors.blueFranceSun113, width: 3)),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerHeight: 0,
            labelStyle: DsfrTextStyle.bodyLgBold(color: DsfrColors.blueFranceSun113),
            labelPadding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
            unselectedLabelStyle: DsfrTextStyle.bodyLg(),
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              _List(
                lessThan1Kg: value.fruitsLessThan1Kg,
                lessThan5Kg: value.fruitsLessThan5Kg,
                moreThan5Kg: value.fruitsMoreThan5Kg,
              ),
              _List(
                lessThan1Kg: value.vegetablesLessThan1Kg,
                lessThan5Kg: value.vegetablesLessThan5Kg,
                moreThan5Kg: value.vegetablesMoreThan5Kg,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header({required this.value});

  final SeasonalFruitsAndVegetablesLoadSuccess value;

  @override
  Widget build(final BuildContext context) => Text.rich(
    TextSpan(
      style: const DsfrTextStyle(fontSize: 28, fontWeight: FontWeight.w500),
      children: [
        const TextSpan(text: Localisation.fruitsEtLegumesTitre),
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: FnvDropdown(
            items: Map.fromEntries(value.months.map((final e) => MapEntry(e.code, e.label))),
            value: value.monthSelected,
            onChanged:
                (final value) =>
                    context.read<SeasonalFruitsAndVegetablesBloc>().add(SeasonalFruitsAndVegetablesMonthSelected(value)),
          ),
        ),
      ],
    ),
  );
}

class _List extends StatelessWidget {
  const _List({required this.lessThan1Kg, required this.lessThan5Kg, required this.moreThan5Kg});

  final List<Plant> lessThan1Kg;
  final List<Plant> lessThan5Kg;
  final List<Plant> moreThan5Kg;

  @override
  Widget build(final BuildContext context) {
    final allItems = [
      if (lessThan1Kg.isNotEmpty)
        _Section(
          title: Localisation.fruitsEtLegumesPeuConsommateurs,
          subtitle: Localisation.fruitsEtLegumesPeuConsommateursDescription,
          items: lessThan1Kg,
        ),
      if (lessThan5Kg.isNotEmpty)
        _Section(
          title: Localisation.fruitsEtLegumesMoyennementConsommateurs,
          subtitle: Localisation.fruitsEtLegumesMoyennementConsommateursDescription,
          items: lessThan5Kg,
        ),
      if (moreThan5Kg.isNotEmpty)
        _Section(
          title: Localisation.fruitsEtLegumesConsommateurs,
          subtitle: Localisation.fruitsEtLegumesConsommateursDescription,
          items: moreThan5Kg,
        ),
      const PartnerCard(
        image: AssetImages.impactCo2Illustration,
        name: Localisation.impactCo2,
        description: Localisation.impactCo2Description,
        url: Localisation.impactCo2Url,
        logo: AssetImages.impactCo2Logo,
      ),
      const SizedBox.shrink(),
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w, horizontal: DsfrSpacings.s2w),
      itemBuilder: (final context, final index) => allItems[index],
      separatorBuilder: (final context, final index) => const SizedBox(height: DsfrSpacings.s4w),
      itemCount: allItems.length,
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.subtitle, required this.items});

  final String title;
  final String subtitle;
  final List<Plant> items;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const DsfrTextStyle.headline4()),
      Text(subtitle, style: const DsfrTextStyle.bodyMd(color: DsfrColors.grey425)),
      const SizedBox(height: DsfrSpacings.s3w),
      ...items.map(
        (final e) => Padding(
          padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s2w / 2),
          child: _PlantCard(
            child: Padding(
              padding: const EdgeInsets.all(DsfrSpacings.s2w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.title, style: const DsfrTextStyle.bodyMd()),
                  FnvImage.network(e.imageUrl, width: 24, height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class _PlantCard extends StatelessWidget {
  const _PlantCard({required this.child});

  final Widget child;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const ShapeDecoration(
      color: FnvColors.carteFond,
      shadows: cardBoxShadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w))),
    ),
    child: child,
  );
}
