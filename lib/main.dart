import 'package:flutter/material.dart';
import 'package:svorc_proto_v1/src/features/core/domain/values/app_repositories_value.dart';
import 'package:svorc_proto_v1/src/features/core/utilities/helpers/app_dependencies_resolver_helper.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_database_wrapper.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

// TODO remove this when time - or maybe not, we will see.
// TODO then leave as long as really no good reason to remove. probably can use some of it
  await settingsController.loadSettings();

  final DriftDatabaseWrapper driftDatabaseWrapper =
      _getInitializedDatabaseWrapper();
  final AppRepositoriesValue appRepositories =
      _getAppRepositories(driftDatabaseWrapper);

  runApp(MyApp(
    settingsController: settingsController,
    appRepositories: appRepositories,
  ));
}

DriftDatabaseWrapper _getInitializedDatabaseWrapper() {
  final DriftDatabaseWrapper driftDatabaseWrapper = DriftDatabaseWrapper.app();
  driftDatabaseWrapper.initialize();

  return driftDatabaseWrapper;
}

AppRepositoriesValue _getAppRepositories(
  DriftDatabaseWrapper databaseWrapper,
) {
  final AppDependenciesResolverHelper appDependenciesResolverHelper =
      AppDependenciesResolverHelper(
    databaseWrapper,
  );

  final AppRepositoriesValue appRepositories =
      appDependenciesResolverHelper.resolveRepositories();

  return appRepositories;
}
