import 'package:app/features/profil/mieux_vous_connaitre/domain/ports/mieux_vous_connaitre_port.dart';
import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';

class MieuxVousConnaitrePortMock implements MieuxVousConnaitrePort {
  const MieuxVousConnaitrePortMock({required this.questions});

  final List<Question> questions;

  @override
  Future<List<Question>> recupererLesQuestionsDejaRepondue() async => questions;
}
