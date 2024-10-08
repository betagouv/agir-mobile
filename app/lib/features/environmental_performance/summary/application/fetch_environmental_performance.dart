import 'package:app/features/environmental_performance/summary/domain/environmental_performance_empty.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_summary.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchEnvironmentalPerformance {
  const FetchEnvironmentalPerformance(this._port);

  final EnvironmentalPerformanceSummaryRepository _port;

  Future<Either<Exception, EnvironmentalPerformanceSummary>> call() async {
    final result = await _port.fetch();

    return result.fold(Left.new, (final r) async {
      if (r.type == EnvironmentalPerformanceSummaryType.empty) {
        final kyc = await _port.fetchMiniBilan();

        return kyc.fold(
          Left.new,
          (final r2) => Right(
            r.copyWith(empty: EnvironmentalPerformanceEmpty(questions: r2)),
          ),
        );
      }

      return Right(r);
    });
  }
}
