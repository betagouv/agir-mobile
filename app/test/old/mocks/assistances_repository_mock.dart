import 'package:app/features/assistances/core/domain/aide.dart';
import 'package:app/features/assistances/list/infrastructure/assistances_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class AssistancesRepositoryMock extends Mock implements AssistancesRepository {
  AssistancesRepositoryMock(this.aides);

  List<Assistance> aides;

  @override
  Future<Either<Exception, AssistanceList>> fetch() async =>
      Right(AssistanceList(isCovered: true, assistances: aides));
}
