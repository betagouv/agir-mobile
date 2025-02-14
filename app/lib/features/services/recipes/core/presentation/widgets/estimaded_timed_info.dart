import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';

class EstimadedTimedInfo extends StatelessWidget {
  const EstimadedTimedInfo({super.key, required this.text});

  final String text;

  @override
  Widget build(final context) {
    const color = Color(0xff6A6A6A);

    return Text.rich(
      TextSpan(
        children: [
          const WidgetSpan(child: Icon(DsfrIcons.systemTimerLine, size: 15, color: color)),
          TextSpan(text: text, style: const DsfrTextStyle.bodyXsMedium(color: color)),
        ],
      ),
    );
  }
}
