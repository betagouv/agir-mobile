import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';

class FnvCodeInput extends StatelessWidget {
  const FnvCodeInput({required this.onChanged, super.key});

  final ValueChanged<String> onChanged;

  @override
  Widget build(final BuildContext context) {
    const width = 48.0;
    const pinTheme = PinTheme(
      width: width,
      height: width * 1.27,
      padding: EdgeInsets.only(
        bottom:
            6, // HACK(lsaudon): Fix vertical alignment parce que la police Marianne est mal pris en compte par flutter
      ),
      textStyle: DsfrTextStyle(fontSize: width * 0.68),
      decoration: BoxDecoration(
        color: FnvColors.aidesFond,
        border: Border.fromBorderSide(BorderSide(color: Color(0xFFB9BEBE))),
        borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1v)),
      ),
    );

    return Pinput(
      length: 6,
      defaultPinTheme: pinTheme,
      focusedPinTheme: pinTheme.copyBorderWith(
        border: const Border.fromBorderSide(
          BorderSide(color: DsfrColors.focus525),
        ),
      ),
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      scrollPadding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom + 130,
      ),
    );
  }
}
