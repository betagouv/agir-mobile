import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_event.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_state.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/empty/body_empty.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/full/body_full.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/body_partial.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EnvironmentalPerformanceSummaryPage extends StatelessWidget {
  const EnvironmentalPerformanceSummaryPage({super.key});

  static const name = 'bilan';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            const EnvironmentalPerformanceSummaryPage(),
      );

  @override
  Widget build(final BuildContext context) {
    context
        .read<EnvironmentalPerformanceBloc>()
        .add(const EnvironmentalPerformanceStarted());

    return const _View();
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => RootPage(
        body: BlocBuilder<EnvironmentalPerformanceBloc,
            EnvironmentalPerformanceState>(
          builder: (final context, final state) => switch (state) {
            EnvironmentalPerformanceInitial() => const SizedBox.shrink(),
            EnvironmentalPerformanceLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            EnvironmentalPerformanceSuccess() => switch (state.data) {
                (final EnvironmentalPerformanceEmpty a) => BodyEmpty(data: a),
                (final EnvironmentalPerformancePartial a) =>
                  BodyPartial(data: a),
                (final EnvironmentalPerformanceFull a) => BodyFull(data: a),
              },
            EnvironmentalPerformanceFailure() => Text(state.errorMessage),
          },
        ),
      );
}
