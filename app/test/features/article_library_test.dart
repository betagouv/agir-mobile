// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_context.dart';
import './step/i_am_logged_in.dart';
import './step/the_application_is_launched.dart';
import './step/i_tap_on_the_menu_button.dart';
import './step/i_have_articles_in_my_library.dart';
import './step/i_tap_on.dart';
import './step/i_see.dart';
import './step/i_enter_in_the_search_by_title_field.dart';
import './step/i_dont_see.dart';
import './step/i_filter_with_theme.dart';
import './step/i_filter_by_favorites.dart';
import './step/i_tap_on_the_first_article.dart';

void main() {
  group('''Article library''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await initializeContext(tester);
      await iAmLoggedIn(tester);
      await theApplicationIsLaunched(tester);
      await iTapOnTheMenuButton(tester);
    }

    testWidgets('''See 1 article''', (tester) async {
      await bddSetUp(tester);
      await iHaveArticlesInMyLibrary(tester, 1);
      await iTapOn(tester, 'Ma bibliothèque');
      await iSee(tester, '1 article');
    });
    testWidgets('''See articles''', (tester) async {
      await bddSetUp(tester);
      await iHaveArticlesInMyLibrary(tester, 2);
      await iTapOn(tester, 'Ma bibliothèque');
      await iSee(tester, '2 articles');
    });
    testWidgets('''See 0 article''', (tester) async {
      await bddSetUp(tester);
      await iHaveArticlesInMyLibrary(tester, 0);
      await iTapOn(tester, 'Ma bibliothèque');
      await iSee(tester, '0 article');
      await iSee(tester, 'Aucun article trouvé');
    });
    testWidgets('''Filter articles by title''', (tester) async {
      await bddSetUp(tester);
      await iHaveArticlesInMyLibrary(tester, 2);
      await iTapOn(tester, 'Ma bibliothèque');
      await iEnterInTheSearchByTitleField(tester, 'vêtements');
      await iSee(tester, '1 article');
      await iSee(tester, "Comment réduire l'impact de ses vêtements ?");
      await iDontSee(tester, "Qu'est-ce qu'une alimentation durable ?");
    });
    testWidgets('''Filter articles by theme''', (tester) async {
      await bddSetUp(tester);
      await iHaveArticlesInMyLibrary(tester, 2);
      await iTapOn(tester, 'Ma bibliothèque');
      await iFilterWithTheme(tester, '🥦 Alimentation');
      await iSee(tester, '1 article');
      await iSee(tester, "Qu'est-ce qu'une alimentation durable ?");
      await iDontSee(tester, "Comment réduire l'impact de ses vêtements ?");
    });
    testWidgets('''Filter articles by favorites''', (tester) async {
      await bddSetUp(tester);
      await iHaveArticlesInMyLibrary(tester, 2);
      await iTapOn(tester, 'Ma bibliothèque');
      await iFilterByFavorites(tester);
      await iSee(tester, '1 article');
      await iSee(tester, "Qu'est-ce qu'une alimentation durable ?");
      await iDontSee(tester, "Comment réduire l'impact de ses vêtements ?");
    });
    testWidgets('''Go to an article''', (tester) async {
      await bddSetUp(tester);
      await iHaveArticlesInMyLibrary(tester, 2);
      await iTapOn(tester, 'Ma bibliothèque');
      await iTapOnTheFirstArticle(tester);
      await iSee(tester, "Qu'est-ce qu'une alimentation durable ?");
      await iSee(tester, "Comment réduire l'impact de notre alimentation sur le climat ?");
    });
  });
}
