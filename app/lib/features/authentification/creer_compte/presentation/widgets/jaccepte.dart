import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Jaccepte extends StatefulWidget {
  const Jaccepte({super.key, required this.label, required this.url, required this.value, required this.onChanged});

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
    _recognizer.onTap = () async => FnvUrlLauncher.launch(widget.url);
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) {
    const style = DsfrTextStyle.bodyMd();
    const jaccepte = Localisation.jaccepte;

    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        checked: widget.value,
        label: '$jaccepte${widget.label}',
        child: Row(
          spacing: DsfrSpacings.s1w,
          children: [
            DsfrCheckboxIcon(value: widget.value),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: jaccepte,
                  children: [
                    TextSpan(
                      text: '${widget.label} ',
                      style: style.copyWith(decoration: TextDecoration.underline),
                      recognizer: _recognizer,
                      children: const [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(DsfrIcons.systemExternalLinkFill, size: 16),
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
      ),
    );
  }
}
