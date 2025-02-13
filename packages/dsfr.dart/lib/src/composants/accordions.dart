// ignore_for_file: prefer-spacing

import 'package:dsfr/src/atoms/focus_widget.dart';
import 'package:dsfr/src/composants/divider.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:dsfr/src/helpers/iterable_extension.dart';
import 'package:flutter/material.dart';

typedef DsfrAccordionCallback = void Function(int panelIndex, bool isExpanded);
typedef DsfrAccordionHeaderBuilder = Widget Function(bool isExpanded);

class DsfrAccordion {
  const DsfrAccordion({required this.headerBuilder, required this.body, this.isEnable = true});

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

  void _handleCallback(final int? panelIndex, final bool isExpanded) => setState(() {
    _panelIndex = panelIndex;
    _isExpanded = isExpanded;
  });

  @override
  Widget build(final context) {
    const divider = DsfrDivider();

    return Column(
      children: [
        divider,
        ...widget.values.indexed
            .map((final (int, DsfrAccordion) e) {
              final index = e.$1;

              return _DsfrAccordion(
                index: index,
                item: e.$2,
                isExpanded: _panelIndex == index && _isExpanded,
                onAccordionCallback: _handleCallback,
              );
            })
            .separator(divider),
        divider,
      ],
    );
  }
}

class _DsfrAccordion extends StatefulWidget {
  const _DsfrAccordion({required this.index, required this.item, required this.isExpanded, required this.onAccordionCallback});

  final int index;
  final DsfrAccordion item;
  final bool isExpanded;
  final DsfrAccordionCallback onAccordionCallback;

  @override
  State<_DsfrAccordion> createState() => _DsfrAccordionState();
}

class _DsfrAccordionState extends State<_DsfrAccordion> with MaterialStateMixin<_DsfrAccordion> {
  void _handleTap() => widget.onAccordionCallback(widget.index, !widget.isExpanded);

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      InkWell(
        onTap: widget.item.isEnable ? _handleTap : null,
        onHighlightChanged: updateMaterialState(WidgetState.pressed),
        onHover: updateMaterialState(WidgetState.hovered),
        focusColor: Colors.transparent,
        onFocusChange: updateMaterialState(WidgetState.focused),
        child: DsfrFocusWidget(
          isFocused: isFocused,
          child: ColoredBox(
            color: widget.isExpanded ? DsfrColors.blueFrance925 : Colors.transparent,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3v),
                child: Row(
                  children: [
                    Expanded(child: widget.item.headerBuilder(widget.isExpanded)),
                    if (widget.item.isEnable)
                      AnimatedRotation(
                        turns: widget.isExpanded ? -0.5 : 0,
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
      ),
      AnimatedCrossFade(
        firstChild: const SizedBox.shrink(),
        secondChild: Padding(
          padding: const EdgeInsets.only(top: DsfrSpacings.s2w, bottom: DsfrSpacings.s3w),
          child: widget.item.body,
        ),
        crossFadeState: widget.isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Durations.short4,
      ),
    ],
  );
}
