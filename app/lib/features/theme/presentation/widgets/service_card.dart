// ... existing code ...

import 'package:app/core/helpers/string.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/services/recipes/list/presentation/pages/recipes_page.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/presentation/pages/seasonal_fruits_and_vegetables_page.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service});

  final ServiceItem service;

  @override
  Widget build(final context) => service.isInternalService ? _InternalServiceCard(service) : _ExternalServiceCard(service);
}

class _ExternalServiceCard extends StatelessWidget {
  const _ExternalServiceCard(this.service);

  final ServiceItem service;

  @override
  Widget build(final context) => _ServiceCardBase(
    service: service,
    backgroundColor: const Color(0xFFEEF2FF),
    borderColor: const Color(0xFFB1B1FF),
    titleColor: DsfrColors.blueFranceSun113,
    subTitleColor: DsfrColors.blueFranceSun113,
    icon: const Icon(DsfrIcons.systemExternalLinkLine, size: 20, color: DsfrColors.blueFranceSun113),
    onTap: () async => FnvUrlLauncher.launch(service.externalUrl),
  );
}

class _InternalServiceCard extends StatelessWidget {
  const _InternalServiceCard(this.service);

  final ServiceItem service;

  @override
  Widget build(final context) => _ServiceCardBase(
    service: service,
    backgroundColor: Colors.white,
    borderColor: Colors.white,
    titleColor: DsfrColors.grey50,
    subTitleColor: DsfrColors.grey425,
    icon: FnvImage.network(service.iconUrl, width: 26, height: 26),
    onTap: () async {
      if (service.isFruitsLegumesService) {
        await GoRouter.of(context).pushNamed(SeasonalFruitsAndVegetablesPage.name);
      } else if (service.isRecipeService) {
        await GoRouter.of(context).pushNamed(RecipesPage.name);
      }
    },
  );
}

class _ServiceCardBase extends StatefulWidget {
  const _ServiceCardBase({
    required this.service,
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.subTitleColor,
    required this.icon,
    required this.onTap,
  });

  final ServiceItem service;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color subTitleColor;
  final Widget icon;
  final VoidCallback onTap;

  @override
  State<_ServiceCardBase> createState() => _ServiceCardBaseState();
}

class _ServiceCardBaseState extends State<_ServiceCardBase> with MaterialStateMixin<_ServiceCardBase> {
  @override
  Widget build(final context) {
    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s1w));

    return DsfrFocusWidget(
      isFocused: isFocused,
      borderRadius: borderRadius,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: widget.backgroundColor,
          shadows: cardBoxShadow,
          shape: RoundedRectangleBorder(side: BorderSide(color: widget.borderColor), borderRadius: borderRadius),
        ),
        child: Material(
          color: FnvColors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            onHighlightChanged: updateMaterialState(WidgetState.pressed),
            onHover: updateMaterialState(WidgetState.hovered),
            focusColor: FnvColors.transparent,
            borderRadius: borderRadius,
            onFocusChange: updateMaterialState(WidgetState.focused),
            child: SizedBox(
              width: 156,
              child: Padding(
                padding: const EdgeInsets.all(DsfrSpacings.s1w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.service.titre, style: DsfrTextStyle.bodyMdMedium(color: widget.titleColor)),
                    const SizedBox(height: DsfrSpacings.s1w),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            capitalize(widget.service.sousTitre),
                            style: DsfrTextStyle.bodySmMedium(color: widget.subTitleColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        widget.icon,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
