import 'package:app/l10n/l10n.dart';
import 'package:app/shared/helpers/input_formatter.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RevenuFiscalInput extends StatelessWidget {
  const RevenuFiscalInput({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final int? initialValue;
  final ValueChanged<int> onChanged;

  @override
  Widget build(final BuildContext context) => DsfrInput(
        label: Localisation.revenuFiscal,
        onChanged: (final value) {
          final parsedValue = currencyFormat.tryParse(value);
          if (parsedValue == null) {
            return;
          }
          onChanged(parsedValue.toInt());
        },
        suffixText: '€',
        initialValue:
            initialValue == null ? null : formatCurrency(initialValue!),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          InputFormatter.currency,
        ],
      );
}
