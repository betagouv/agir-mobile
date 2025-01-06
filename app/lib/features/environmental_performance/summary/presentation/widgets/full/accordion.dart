import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';

typedef FnvAccordionCallback = void Function(int panelIndex, bool isExpanded);
typedef FnvAccordionHeaderBuilder = Widget Function(bool isExpanded);

class FnvAccordion {
  const FnvAccordion({
    required this.headerBuilder,
    required this.body,
    this.isEnable = true,
  });

  final FnvAccordionHeaderBuilder headerBuilder;
  final Widget body;
  final bool isEnable;
}

class FnvAccordionsGroup extends StatefulWidget {
  const FnvAccordionsGroup({super.key, required this.values});

  final List<FnvAccordion> values;

  @override
  State<FnvAccordionsGroup> createState() => _FnvAccordionsGroupState();
}

class _FnvAccordionsGroupState extends State<FnvAccordionsGroup> {
  int? _panelIndex;
  bool _isExpanded = false;

  @override
  Widget build(final context) {
    const divider = DsfrDivider();

    return Column(
      children: [
        divider,
        ...widget.values.indexed.map((final (int, FnvAccordion) e) {
          final index = e.$1;

          return _FnvAccordion(
            index: index,
            item: e.$2,
            isExpanded: _panelIndex == index && _isExpanded,
            onAccordionCallback: (final panelIndex, final isExpanded) =>
                setState(() {
              _panelIndex = panelIndex;
              _isExpanded = isExpanded;
            }),
          );
        }).separator(divider),
        divider,
      ],
    );
  }
}

class _FnvAccordion extends StatelessWidget {
  const _FnvAccordion({
    required this.index,
    required this.item,
    required this.isExpanded,
    required this.onAccordionCallback,
  });

  final int index;
  final FnvAccordion item;
  final bool isExpanded;
  final FnvAccordionCallback onAccordionCallback;

  void _handleTap() => onAccordionCallback(index, !isExpanded);

  @override
  Widget build(final context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: item.isEnable ? _handleTap : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3v),
              child: Row(
                children: [
                  Expanded(child: item.headerBuilder(isExpanded)),
                  if (item.isEnable)
                    AnimatedRotation(
                      turns: isExpanded ? 0.25 : 0,
                      duration: Durations.short4,
                      child: const Icon(
                        DsfrIcons.systemArrowRightSLine,
                        size: DsfrSpacings.s3w,
                        color: Color(0xFF491273),
                      ),
                    ),
                  const SizedBox(width: DsfrSpacings.s2w),
                ],
              ),
            ),
          ),
          if (isExpanded) const DsfrDivider(),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color(0xFFF2F2F2),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D150323),
                    offset: Offset(0, 6),
                    blurRadius: 6,
                    inset: true,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: DsfrSpacings.s2w,
                  bottom: DsfrSpacings.s3w,
                ),
                child: item.body,
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Durations.short4,
          ),
        ],
      );
}
