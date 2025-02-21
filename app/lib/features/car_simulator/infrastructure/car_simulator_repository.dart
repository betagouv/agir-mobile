// ignore_for_file: avoid-long-parameter-list

import 'dart:io';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/car_simulator/domain/car_simulator.dart';
import 'package:app/features/car_simulator/infrastructure/car_simulator_mapper.dart';
import 'package:fpdart/fpdart.dart';

class CarSimulatorRepository {
  const CarSimulatorRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;
  Future<Either<Exception, CurrentCar>> computeCurrentCar(
    // TODO(erolley): Handle the target car size and the electric status in the
    // same way that we handle the "état du vélo" in the AideVeloRepository.
    // Need to add the payload in the API -> Therefore, we no longer need the
    // `/utilisateurs/{utilisateurId}/simulateur_voiture/resultat/voiture_cible`
    // endpoint.
    // {
    //   // required final CarSize carSize,
    //   // required final boolean isElectric,
    // }
  ) async {
    final response = await _client.get(Endpoints.carSimulatorComputeCurrentCar);

    if (response.statusCode! >= HttpStatus.badRequest) {
      return Left(Exception('Erreur lors de la simulation de la voiture actuelle: $response'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(CurrentCarMapper.fromJson(json));
  }
}
