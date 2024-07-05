// ignore_for_file: avoid-collection-mutating-methods

import 'package:app/features/profil/mieux_vous_connaitre/domain/ports/mieux_vous_connaitre_port.dart';
import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
import 'package:collection/collection.dart';

class MieuxVousConnaitrePortMock implements MieuxVousConnaitrePort {
  MieuxVousConnaitrePortMock({required this.questions});

  List<Question> questions;

  @override
  Future<List<Question>> recupererLesQuestionsDejaRepondue() async => questions;

  @override
  Future<void> mettreAJour({
    required final String id,
    required final List<String> reponses,
  }) async {
    final question = questions.firstWhereOrNull((final e) => e.id == id);
    if (question != null) {
      questions
        ..removeWhere((final e) => e.id == id)
        ..add(question.copyWith(reponses: reponses));
    }
  }
}
