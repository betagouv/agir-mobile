import 'package:intl/intl.dart';

abstract final class FnvNumberFormat {
  /// Formate un [nombre] en utilisant un modèle de format '0.##'.
  ///
  /// Le paramètre [nombre] est le nombre à formater.
  ///
  /// Renvoie le nombre formaté sous forme de chaîne de caractères.
  ///
  /// Exemple:
  /// ```md
  /// 1234.567 -> 1234,56
  /// 1234.56 -> 1234,56
  /// 1234.5 -> 1234,5
  /// 1234.0 -> 1234
  /// ```
  static String formatNumber(final double nombre) =>
      NumberFormat('0.##', 'fr').format(nombre);
}
