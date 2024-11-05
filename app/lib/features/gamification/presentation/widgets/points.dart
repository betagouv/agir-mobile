import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(final context) {
    final state = context.watch<GamificationBloc>().state;

    return Semantics(
      label: Localisation.nombrePoints(state.points),
      child: ExcludeSemantics(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xFFF1F6EC),
            borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DsfrSpacings.s1v5,
              horizontal: DsfrSpacings.s1w,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${state.points}',
                  key: ValueKey('${state.points}points'),
                  style: const DsfrTextStyle.bodySmBold(),
                ),
                const SizedBox(width: DsfrSpacings.s1v),
                const Icon(
                  DsfrIcons.othersLeafFill,
                  size: DsfrSpacings.s2w,
                  color: Color(0xFF3CD277),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
