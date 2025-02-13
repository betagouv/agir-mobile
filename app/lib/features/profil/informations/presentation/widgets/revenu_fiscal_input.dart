import 'package:app/core/helpers/input_formatter.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RevenuFiscalInput extends StatelessWidget {
  const RevenuFiscalInput({super.key, required this.initialValue, required this.onChanged});

  final int? initialValue;
  final ValueChanged<int> onChanged;

  @override
  Widget build(final context) => DsfrInput(
    label: Localisation.revenuFiscal,
    suffixText: '€',
    initialValue: initialValue == null ? null : formatCurrency(initialValue!),
    onChanged: (final value) {
      final parsedValue = currencyFormat.tryParse(value);
      if (parsedValue == null) {
        return;
      }
      onChanged(parsedValue.toInt());
    },
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly, InputFormatter.currency],
  );
}
