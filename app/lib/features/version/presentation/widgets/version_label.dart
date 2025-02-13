import 'package:app/features/version/presentation/bloc/version_bloc.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionLabel extends StatelessWidget {
  const VersionLabel({super.key});

  @override
  Widget build(final context) {
    final version = context.select<VersionBloc, String>(
      (final bloc) => bloc.state.value,
    );

    return Text(
      version,
      style: const DsfrTextStyle.bodyMd(color: Color(0x7F000000)),
    );
  }
}
