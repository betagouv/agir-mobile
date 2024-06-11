import 'package:dsfr/src/composants/divider.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:dsfr/src/helpers/iterable_extension.dart';
import 'package:flutter/material.dart';

// C'est un typedef, on peut pas faire de parametre nommé.
// ignore: avoid_positional_boolean_parameters, prefer-named-boolean-parameters
typedef DsfrAccordionCallback = void Function(int panelIndex, bool isExpanded);

class DsfrAccordion {
  const DsfrAccordion({required this.header, required this.body});

  final Widget header;
  final Widget body;
}

class DsfrAccordionsGroup extends StatefulWidget {
  const DsfrAccordionsGroup({required this.values, super.key});

  final List<DsfrAccordion> values;

  @override
  State<DsfrAccordionsGroup> createState() => _DsfrAccordionsGroupState();
}

class _DsfrAccordionsGroupState extends State<DsfrAccordionsGroup> {
  int? _panelIndex;
  bool _isExpanded = false;

  void _handleCallback(final int? panelIndex, final bool isExpanded) =>
      setState(() {
        _panelIndex = panelIndex;
        _isExpanded = isExpanded;
      });

  @override
  Widget build(final context) {
    const divider = DsfrDivider();

    return Column(
      children: [
        divider,
        ...widget.values.indexed.map((final (int, DsfrAccordion) e) {
          final index = e.$1;

          return _DsfrAccordion(
            index: index,
            item: e.$2,
            isExpanded: _panelIndex == index && _isExpanded,
            onAccordionCallback: _handleCallback,
          );
        }).separator(divider),
        divider,
      ],
    );
  }
}

class _DsfrAccordion extends StatelessWidget {
  const _DsfrAccordion({
    required this.index,
    required this.item,
    required this.isExpanded,
    required this.onAccordionCallback,
  });

  final int index;
  final DsfrAccordion item;
  final bool isExpanded;
  final DsfrAccordionCallback onAccordionCallback;

  void _handleTap() => onAccordionCallback(index, !isExpanded);

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: isExpanded ? DsfrColors.blueFrance925 : Colors.transparent,
            child: GestureDetector(
              onTap: _handleTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3v),
                child: Row(
                  children: [
                    Expanded(child: item.header),
                    Icon(
                      isExpanded
                          ? DsfrIcons.systemArrowUpSLine
                          : DsfrIcons.systemArrowDownSLine,
                      size: DsfrSpacings.s2w,
                      color: DsfrColors.blueFranceSun113,
                    ),
                    const SizedBox(width: DsfrSpacings.s2w),
                  ],
                ),
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(
                top: DsfrSpacings.s2w,
                bottom: DsfrSpacings.s3w,
              ),
              child: item.body,
            ),
        ],
      );
}
