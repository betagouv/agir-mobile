import 'package:app/features/articles/domain/partner.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

class Aid extends Equatable {
  const Aid({
    required this.themeType,
    required this.title,
    required this.content,
    this.amountMax,
    this.simulatorUrl,
    this.partner,
  });

  final ThemeType themeType;
  final String title;
  final String content;
  final int? amountMax;
  final String? simulatorUrl;
  bool get aUnSimulateur => simulatorUrl != null && simulatorUrl!.isNotEmpty;
  bool get estSimulateurVelo => simulatorUrl == '/aides/velo';

  final Partner? partner;

  @override
  List<Object?> get props => [title, themeType, content, amountMax, simulatorUrl, partner];
}
