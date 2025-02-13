import 'dart:io';

import 'package:app/features/upgrade/presentation/bloc/upgrade_bloc.dart';
import 'package:app/features/upgrade/presentation/bloc/upgrade_event.dart';
import 'package:dio/dio.dart';

class UpgradeInterceptor extends Interceptor {
  const UpgradeInterceptor(this.upgradeBloc);

  final UpgradeBloc upgradeBloc;

  @override
  void onResponse(final Response<dynamic> response, final ResponseInterceptorHandler handler) {
    if (response.statusCode == HttpStatus.gone) {
      upgradeBloc.add(const UpgradeRequested());
    }
    handler.next(response);
  }
}
