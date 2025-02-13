import 'package:app/core/presentation/widgets/composants/dropdown_button_raw.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvDropdown<T> extends StatelessWidget {
  const FnvDropdown({super.key, required this.items, required this.value, required this.onChanged});

  final Map<T, String> items;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(final context) => DropdownButtonRaw<T>(
    items: Map.fromEntries(
      items.entries.map(
        (final entry) => MapEntry(
          entry.key,
          SizedBox(
            height: 48,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(alignment: Alignment.centerLeft, child: Text(entry.value, style: const DsfrTextStyle.bodyMd())),
            ),
          ),
        ),
      ),
    ),
    selectedItem: MapEntry(
      value,
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: CustomPaint(
              painter: const _DottedLinePainter(),
              child: Text(items[value]!, style: const DsfrTextStyle.headline2(color: DsfrColors.blueFranceSun113)),
            ),
          ),
          const Padding(
            // HACK(lsaudon): Pour aligner l'icône
            padding: EdgeInsets.only(top: 10),
            child: Icon(DsfrIcons.systemArrowDownSLine, size: 24, color: DsfrColors.blueFranceSun113),
          ),
        ],
      ),
    ),
    onChanged: (final value) {
      if (value == null) {
        return;
      }
      onChanged(value);
    },
    menuStyle: const DropdownMenuStyle(
      decoration: ShapeDecoration(
        color: Color(0xFFFFFFFF),
        shadows: [BoxShadow(color: Color(0x0D000000), offset: Offset(0, 4), blurRadius: 4)],
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0x0D000000)),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      alignment: Alignment.bottomLeft,
      offset: Offset(0, 8),
    ),
  );
}

class _DottedLinePainter extends CustomPainter {
  const _DottedLinePainter();
  @override
  void paint(final Canvas canvas, final Size size) {
    final paint =
        Paint()
          ..color = DsfrColors.blueFranceSun113
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 1.0;
    var startX = 0.0;

    while (startX < size.width) {
      final height = size.height + 3;
      canvas.drawLine(Offset(startX, height), Offset(startX + dashWidth, height), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(final CustomPainter oldDelegate) => false;
}
