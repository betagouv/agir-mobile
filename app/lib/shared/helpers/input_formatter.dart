import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

abstract final class InputFormatter {
  static final currency =
      TextInputFormatter.withFunction((final oldValue, final newValue) {
    final text = newValue.text.replaceAll(' ', '');
    if (text.isEmpty) return newValue;
    final number = int.parse(text);
    final newString = formatCurrency(number);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  });
}

NumberFormat get currencyFormat => NumberFormat.currency(
      locale: 'fr_FR',
      symbol: '',
      decimalDigits: 0,
    );

String formatCurrency(final int value) => currencyFormat.format(value).trim();
