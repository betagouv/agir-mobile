import 'package:app/features/recommandations/presentation/blocs/recommandations_bloc.dart';
import 'package:app/features/recommandations/presentation/blocs/recommandations_event.dart';
import 'package:app/features/recommandations/presentation/widgets/les_recommandations.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final mesRecommandationsRouteObserver = RouteObserver<ModalRoute<Object?>>();

class MesRecommandations extends StatefulWidget {
  const MesRecommandations({super.key, this.thematique});

  final String? thematique;

  @override
  State<MesRecommandations> createState() => _MesRecommandationsState();
}

class _MesRecommandationsState extends State<MesRecommandations>
    with RouteAware {
  void _handleRecommendations() {
    context
        .read<RecommandationsBloc>()
        .add(RecommandationsRecuperationDemandee(widget.thematique));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mesRecommandationsRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() => _handleRecommendations();

  @override
  void didPush() => _handleRecommendations();

  @override
  void dispose() {
    mesRecommandationsRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => const _View();
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: const [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Localisation.accueilRecommandationsTitre,
                style: DsfrTextStyle.headline5(),
              ),
              SizedBox(height: DsfrSpacings.s1v5),
              Text(
                Localisation.accueilRecommandationsSousTitre,
                style: DsfrTextStyle.bodyMd(),
              ),
            ],
          ),
          SizedBox(height: DsfrSpacings.s2w),
          LesRecommandations(),
        ],
      );
}
