import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/inkwell.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FranceConnectSection extends StatelessWidget {
  const FranceConnectSection({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(Localisation.franceConnectTitle, style: DsfrTextStyle.headline2()),
      const SizedBox(height: DsfrSpacings.s1w),
      const Text(Localisation.franceConnectDescription, style: DsfrTextStyle.bodyLg()),
      const SizedBox(height: DsfrSpacings.s3w),
      _FranceConnectButton(onTap: () => context.read<AuthentificationRepository>().franceConnectStep1()),
    ],
  );
}

class _FranceConnectButton extends StatelessWidget {
  const _FranceConnectButton({required this.onTap});

  final GestureTapCallback onTap;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s3v,
    children: [
      FnvInkwell(
        onTap: onTap,
        color: DsfrColors.blueFranceSun113,
        splashColor: DsfrColors.blueFranceSun113Active,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: DsfrSpacings.s1v, horizontal: DsfrSpacings.s3v),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: DsfrSpacings.s3v,
            children: [
              FnvImage.asset(AssetImages.franceConnect, width: 40),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Localisation.franceConnectPrefix, style: DsfrTextStyle(fontSize: 17, color: Colors.white, height: 1)),
                    Text(
                      Localisation.franceConnect,
                      style: DsfrTextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, height: 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      _TextButton(
        label: Localisation.franceConnectEnSavoirPlus,
        onTap: () async => FnvUrlLauncher.launch(Localisation.franceConnectEnSavoirPlusUrl),
      ),
    ],
  );
}

class _TextButton extends StatelessWidget {
  const _TextButton({required this.label, required this.onTap});

  final String label;
  final GestureTapCallback onTap;

  @override
  Widget build(final context) => FnvInkwell(
    onTap: onTap,
    color: Colors.transparent,
    splashColor: Colors.transparent,
    child: Text.rich(
      TextSpan(
        text: '$label ',
        children: const [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Icon(DsfrIcons.systemExternalLinkFill, size: 16, color: DsfrColors.blueFranceSun113),
          ),
        ],
      ),
      style: const DsfrTextStyle.bodySm(color: DsfrColors.blueFranceSun113).copyWith(decoration: TextDecoration.underline),
    ),
  );
}
