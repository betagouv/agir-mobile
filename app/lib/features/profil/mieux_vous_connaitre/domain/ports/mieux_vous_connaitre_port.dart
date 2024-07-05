import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';

abstract interface class MieuxVousConnaitrePort {
  Future<List<Question>> recupererLesQuestionsDejaRepondue();

  Future<void> mettreAJour({
    required final String id,
    required final List<String> reponses,
  });
}
