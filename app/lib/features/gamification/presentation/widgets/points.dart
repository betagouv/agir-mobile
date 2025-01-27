import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(final context) => const DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xFFF1F6EC),
          borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: DsfrSpacings.s1v5,
            horizontal: DsfrSpacings.s1w,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Content(),
              SizedBox(width: DsfrSpacings.s1v),
              ExcludeSemantics(
                child: Icon(
                  DsfrIcons.othersLeafFill,
                  size: DsfrSpacings.s2w,
                  color: Color(0xFF3CD277),
                ),
              ),
            ],
          ),
        ),
      );
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(final BuildContext context) {
    final points = context
        .select<GamificationBloc, int>((final value) => value.state.points);

    return Text(
      '$points',
      style: const DsfrTextStyle.bodySmBold(),
      semanticsLabel: Localisation.nombrePoints(points),
    );
  }
}
