import 'package:app/features/car_simulator/domain/car_simulator.dart';
import 'package:app/features/car_simulator/presentation/bloc/car_simulator_bloc.dart';
import 'package:app/features/car_simulator/presentation/bloc/car_simulator_event.dart';
import 'package:app/features/car_simulator/presentation/bloc/car_simulator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarSimulatorResult extends StatelessWidget {
  const CarSimulatorResult({super.key});

  @override
  Widget build(final context) {
    context.read<CarSimulatorBloc>().add(const CarSimulatorGetCurrentCarResult());
    final state = context.watch<CarSimulatorBloc>().state;
    // NOTE(erolley): do we need an FnvScaffold here?
    return switch (state) {
      CarSimulatorInitial() || CarSimulatorLoading() => const Center(child: CircularProgressIndicator()),
      CarSimulatorSuccess() => _CarSimulatorResultView(state),
      CarSimulatorLoadFailure(:final errorMessage) => Center(child: Text(errorMessage)),
    };
  }
}

class _CarSimulatorResultView extends StatelessWidget {
  const _CarSimulatorResultView(this.state);

  final CarSimulatorState state;

  @override
  Widget build(final BuildContext context) => const Text('Car Simulator Result');
}
