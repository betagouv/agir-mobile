import 'package:app/features/gamification/presentation/blocs/gamification_bloc.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(final BuildContext context) => const DecoratedBox(
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
              _Value(),
              SizedBox(width: DsfrSpacings.s1v),
              Icon(
                DsfrIcons.othersLeafFill,
                size: DsfrSpacings.s2w,
                color: Color(0xFF3CD277),
              ),
            ],
          ),
        ),
      );
}

class _Value extends StatelessWidget {
  const _Value();

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<GamificationBloc>().state;

    return Text(
      '${state.points}',
      key: ValueKey('${state.points}points'),
      style: const DsfrTextStyle.bodySmBold(),
    );
  }
}
