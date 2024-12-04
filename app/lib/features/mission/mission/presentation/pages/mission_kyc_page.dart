import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mieux_vous_connaitre_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mieux_vous_connaitre_form.dart';
import 'package:app/features/mission/mission/domain/mission_kyc.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_bloc.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionKycPage extends StatefulWidget {
  const MissionKycPage({super.key, required this.value});

  final MissionKyc value;

  @override
  State<MissionKycPage> createState() => _MissionKycPageState();
}

class _MissionKycPageState extends State<MissionKycPage> {
  final _mieuxVousConnaitreController = MieuxVousConnaitreController();

  @override
  void dispose() {
    _mieuxVousConnaitreController.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) => ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          MieuxVousConnaitreForm(
            id: widget.value.contentId.value,
            controller: _mieuxVousConnaitreController,
            onSaved: () =>
                context.read<MissionBloc>().add(const MissionNextRequested()),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          SafeArea(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: DsfrButton(
                  label: Localisation.continuer,
                  variant: DsfrButtonVariant.primary,
                  size: DsfrButtonSize.lg,
                  onPressed: _mieuxVousConnaitreController.save,
                ),
              ),
            ),
          ),
        ],
      );
}
