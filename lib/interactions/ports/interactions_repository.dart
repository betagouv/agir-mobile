
import '../fetchInteractions_usecase.dart';

abstract class InteractionsRepository {
  Future<List<Interaction>> getInteractions(String userId);
}