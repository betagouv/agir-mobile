import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_event.dart';
import 'package:app/features/environmental_performance/questions/presentation/page/environmental_performance_question_page.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_category.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_event.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/environmental_performance_category_widget.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EnvironmentalPerformanceCategories extends StatelessWidget {
  const EnvironmentalPerformanceCategories({super.key, required this.categories});

  final List<EnvironmentalPerformanceCategory> categories;

  @override
  Widget build(final context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: EdgeInsets.zero,
    clipBehavior: Clip.none,
    child: IntrinsicHeight(
      child: Row(
        spacing: DsfrSpacings.s2w,
        children:
            categories
                .map(
                  (final e) => EnvironmentalPerformanceCategoryWidget(
                    imageUrl: e.imageUrl,
                    completion: e.percentageCompletion,
                    label: e.label,
                    numberOfQuestions: e.totalNumberQuestions,
                    onTap: () async {
                      context.read<EnvironmentalPerformanceQuestionBloc>().add(
                        EnvironmentalPerformanceQuestionIdListRequested(e.id),
                      );
                      await GoRouter.of(
                        context,
                      ).pushNamed(EnvironmentalPerformanceQuestionPage.name, pathParameters: {'number': '1'});

                      if (!context.mounted) {
                        return;
                      }

                      context.read<EnvironmentalPerformanceBloc>().add(const EnvironmentalPerformanceStarted());
                    },
                  ),
                )
                .toList(),
      ),
    ),
  );
}
