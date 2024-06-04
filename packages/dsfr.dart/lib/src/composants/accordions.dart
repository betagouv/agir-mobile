import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

// ignore: avoid_positional_boolean_parameters
typedef DsfrAccordionCallback = void Function(int panelIndex, bool isExpanded);

@immutable
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

  @override
  Widget build(final context) {
    const divider = Divider(
      color: DsfrColors.grey900,
      height: 0,
      thickness: 0,
    );
    return Column(
      children: [
        divider,
        ...widget.values.indexed.map(
          (final e) {
            final index = e.$1;
            return _DsfrAccordion(
              index: index,
              item: e.$2,
              isExpanded: _panelIndex == index && _isExpanded,
              accordionCallback: (final panelIndex, final isExpanded) {
                setState(() {
                  _panelIndex = panelIndex;
                  _isExpanded = isExpanded;
                });
              },
            );
          },
        ).separator(divider),
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
    required this.accordionCallback,
  });

  final int index;
  final DsfrAccordion item;
  final bool isExpanded;
  final DsfrAccordionCallback accordionCallback;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: isExpanded ? DsfrColors.blueFrance925 : Colors.transparent,
            child: GestureDetector(
              onTap: () {
                accordionCallback.call(index, !isExpanded);
              },
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
                      color: DsfrColors.blueFranceSun113,
                      size: DsfrSpacings.s2w,
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
