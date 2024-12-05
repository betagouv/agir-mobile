import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_mapper.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:fpdart/fpdart.dart';

class EnvironmentalPerformanceSummaryRepository {
  const EnvironmentalPerformanceSummaryRepository({
    required final DioHttpClient client,
  }) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, EnvironmentalPerformanceData>> fetch() async {
    final response = await _client.get(Endpoints.bilan);
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
      Endpoints.questions('ENCHAINEMENT_KYC_mini_bilan_carbone'),
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
