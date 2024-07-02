import 'package:app/features/version/presentation/blocs/version_bloc.dart';
import 'package:app/features/version/presentation/blocs/version_state.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionLabel extends StatelessWidget {
  const VersionLabel({super.key});

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<VersionBloc, VersionState>(
        builder: (final context, final state) => Text(
          state.value,
          style: const DsfrTextStyle.bodyMd(color: Color(0x7F000000)),
        ),
      );
}
