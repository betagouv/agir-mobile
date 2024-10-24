import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_summary.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_mapper.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/core/infrastructure/question_mapper.dart';
import 'package:fpdart/fpdart.dart';

class EnvironmentalPerformanceSummaryRepository {
  const EnvironmentalPerformanceSummaryRepository({
    required final DioHttpClient client,
  }) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, EnvironmentalPerformanceSummary>> fetch() async {
    final response = await _client.get('/utilisateur/{userId}/bilans/last');
    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(
        Exception('Erreur lors de la récupération du bilan environnemental'),
      );
    }

    final data = response.data! as Map<String, dynamic>;

    return Right(
      EnvironmentalPerformanceSummaryMapperyMapper.fromJson(data),
    );
  }

  Future<Either<Exception, List<Question>>> fetchMiniBilan() async {
    final response = await _client.get(
      '/utilisateurs/{userId}/enchainementQuestionsKYC/ENCHAINEMENT_KYC_mini_bilan_carbone',
    );
    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du mini bilan'));
    }

    final data = response.data! as List<dynamic>;

    return Right(
      data
          .map((final e) => e as Map<String, dynamic>)
          .map(QuestionMapper.fromJson)
          .whereType<Question>()
          .toList(),
    );
  }
}
