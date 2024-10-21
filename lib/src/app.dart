import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/repositories/categories_repository.dart';
import 'package:svorc_proto_v1/src/features/core/domain/values/app_repositories_value.dart';
import 'package:svorc_proto_v1/src/features/core/presentation/screens/home/home_screen.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.settingsController,
      required this.appRepositories});

  final SettingsController settingsController;
  final AppRepositoriesValue appRepositories;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        // TODO this could probably be extracted to a separate widget later - some AppRepositoriesProvider
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<PeriodDailyBudgetsRepository>.value(
              value: appRepositories.periodDailyBudgetsRepository,
            ),
            RepositoryProvider<ExpensesRepository>.value(
              value: appRepositories.expensesRepository,
            ),
            RepositoryProvider<CategoriesRepository>.value(
              value: appRepositories.categoriesRepository,
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // home: const HomeScreenOld(),
            home: const HomeScreen(),

            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',

            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            //
            // The appTitle is defined in .arb files found in the localization
            // directory.
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,

            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // SettingsController to display the correct theme.
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,

            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            // onGenerateRoute: (RouteSettings routeSettings) {
            //   return MaterialPageRoute<void>(
            //     settings: routeSettings,
            //     builder: (BuildContext context) {
            //       switch (routeSettings.name) {
            //         case SettingsView.routeName:
            //           return SettingsView(controller: settingsController);
            //         case SampleItemDetailsView.routeName:
            //           return const SampleItemDetailsView();
            //         case SampleItemListView.routeName:
            //         default:
            //           return const SampleItemListView();
            //       }
            //     },
            //   );
            // },
          ),
        );
      },
    );
  }
}
