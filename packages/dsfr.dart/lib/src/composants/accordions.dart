import 'package:dsfr/src/composants/divider.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:dsfr/src/helpers/iterable_extension.dart';
import 'package:flutter/material.dart';

typedef DsfrAccordionCallback = void Function(int panelIndex, bool isExpanded);
typedef DsfrAccordionHeaderBuilder = Widget Function(bool isExpanded);

class DsfrAccordion {
  const DsfrAccordion({
    required this.headerBuilder,
    required this.body,
    this.isEnable = true,
  });

  final DsfrAccordionHeaderBuilder headerBuilder;
  final Widget body;
  final bool isEnable;
}

class DsfrAccordionsGroup extends StatefulWidget {
  const DsfrAccordionsGroup({super.key, required this.values});

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
  Widget build(final context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: isExpanded ? DsfrColors.blueFrance925 : Colors.transparent,
            child: GestureDetector(
              onTap: item.isEnable ? _handleTap : null,
              behavior: HitTestBehavior.opaque,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: DsfrSpacings.s3v),
                  child: Row(
                    children: [
                      Expanded(child: item.headerBuilder(isExpanded)),
                      if (item.isEnable)
                        AnimatedRotation(
                          turns: isExpanded ? -0.5 : 0,
                          duration: Durations.short4,
                          child: const Icon(
                            DsfrIcons.systemArrowDownSLine,
                            size: DsfrSpacings.s2w,
                            color: DsfrColors.blueFranceSun113,
                          ),
                        ),
                      const SizedBox(width: DsfrSpacings.s2w),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(
                top: DsfrSpacings.s2w,
                bottom: DsfrSpacings.s3w,
              ),
              child: item.body,
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Durations.short4,
          ),
        ],
      );
}
