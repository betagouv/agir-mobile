import 'package:app/core/presentation/widgets/composants/fnv_image.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/widgets/mosaic_button.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mosaic extends StatelessWidget {
  const Mosaic({super.key, required this.question});

  final MosaicQuestion question;

  @override
  Widget build(final BuildContext context) =>
      _MosaicSet(responses: question.responses);
}

class _MosaicSet extends StatefulWidget {
  const _MosaicSet({required this.responses});

  final List<MosaicResponse> responses;

  @override
  State<_MosaicSet> createState() => _MosaicSetState();
}

class _MosaicSetState extends State<_MosaicSet> {
  List<MosaicResponse> _responses = [];

  @override
  void initState() {
    super.initState();
    _responses = widget.responses;
  }

  @override
  Widget build(final BuildContext context) => Wrap(
        spacing: DsfrSpacings.s2w,
        runSpacing: DsfrSpacings.s2w,
        children: _responses.map((final e) {
          const size = 40.0;

          return MosaicButton(
            emoji:
                FnvImage.network(e.imageUrl.value, width: size, height: size),
            title: e.label.value,
            value: e.isSelected,
            onChanged: (final value) {
              setState(() {
                _responses = _responses
                    .map(
                      (final r) => r.id == e.id
                          ? MosaicResponse(
                              id: r.id,
                              imageUrl: r.imageUrl,
                              label: r.label,
                              isSelected: value,
                            )
                          : r,
                    )
                    .toList();
                context
                    .read<MieuxVousConnaitreEditBloc>()
                    .add(MieuxVousConnaitreEditMosaicChangee(_responses));
              });
            },
          );
        }).toList(),
      );
}
