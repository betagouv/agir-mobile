import '../scenario_context.dart';

/// Iel a ces informations de profile.
void ielACesInformationsDeProfil({
  required final String codePostal,
  required final String ville,
  required final double nombreDePartsFiscales,
  required final int? revenuFiscal,
}) {
  ScenarioContext().codePostal = codePostal;
  ScenarioContext().ville = ville;
  ScenarioContext().nombreDePartsFiscales = nombreDePartsFiscales;
  ScenarioContext().revenuFiscal = revenuFiscal;
}
