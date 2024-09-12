import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Jaccepte extends StatefulWidget {
  const Jaccepte({
    super.key,
    required this.label,
    required this.url,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String url;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<Jaccepte> createState() => _JaccepteState();
}

class _JaccepteState extends State<Jaccepte> {
  final _recognizer = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    _recognizer.onTap = () async => launchUrlString(widget.url);
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    const style = DsfrTextStyle.bodyMd();
    const jaccepte = Localisation.jaccepte;

    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Semantics(
            checked: widget.value,
            label: '$jaccepte${widget.label}',
            onTap: () => widget.onChanged(!widget.value),
            child: DsfrCheckboxIcon(value: widget.value),
          ),
          const SizedBox(width: DsfrSpacings.s1w),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: jaccepte,
                children: [
                  TextSpan(
                    text: '${widget.label} ',
                    style: style.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: _recognizer,
                    // semanticsLabel: 'Lien vers ${widget.label}',
                    children: const [
                      WidgetSpan(
                        child: Icon(
                          DsfrIcons.systemExternalLinkFill,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
