import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_bloc.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_event.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_state.dart';
import 'package:app/features/bibliotheque/presentation/pages/bibliotheque_view.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BibliothequePage extends StatelessWidget {
  const BibliothequePage({super.key});

  static const name = 'bibliotheque';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const BibliothequePage());

  @override
  Widget build(final context) {
    context.read<BibliothequeBloc>().add(const BibliothequeRecuperationDemandee());

    return RootPage(
      body: BlocSelector<BibliothequeBloc, BibliothequeState, BibliothequeStatut>(
        selector: (final state) => state.statut,
        builder: (final context, final state) {
          switch (state) {
            case BibliothequeStatut.initial:
            case BibliothequeStatut.chargement:
              return const Center(child: CircularProgressIndicator());
            case BibliothequeStatut.succes:
              return const BibliothequeView();
          }
        },
      ),
    );
  }
}
