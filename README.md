# svorc_proto_v1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)


/// setup db

how to setup drfit

1. install dependencies 
2. create wrapper folder 
3. create folder migrations
	we will create migratior

import 'package:drift/drift.dart';

import 'package:drift/drift.dart';

class DriftAppDatabaseMigrator {
  final MigrationStrategy migrationStrategy = MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      // SOME POPULATE THINGS IF NEEDED
    },
    // TODO this will be generated for us
    // onUpgrade: (m, from, to) async {
    //   // SOME MIGRATIONS IF NEEDED
    // },
  );
}



3. create file app_database
4. annotate new class with Drift database
5. no need for tables yet
- make sure that schema version is present 
make sure migration stragtegy i present


import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/migrations/drift_app_database_migrations_wrapper.dart';

@DriftDatabase(
  tables: [],
)
class DriftAppDatabase extends _$DriftAppDatabase {
  DriftAppDatabase(QueryExecutor e) : super(e);

  final DriftAppDatabaseMigrationsWrapper _migrationsWrapper =
      DriftAppDatabaseMigrationsWrapper();

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => _migrationsWrapper.migrationStrategy;
}

6. add to make make file

generate: 
	dart run build_runner build --delete-conflicting-outputs && flutter pub get

serve_fake: 
	cd fake_server; npx json-server --watch db.json

generate_clean_cache:
	dart run build_runner clean

just_example_how_to_add_env_vars_to_built_app:
	flutter build appbundle --flavor production -t lib/main_production.dart --dart-define-from-file=.env

tests:
	flutter test

  7. run genertate


  ------

  1. now need to setub query exectzutor for sqlite 
  - install following 
  flutter pub add p
ath_provider path sqlite3_flutter_libs
- and then create executor


import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

class SqliteQueryExecutor {
  QueryExecutor get executor {
    final LazyDatabase lazyDatabase = LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, "db.sqlite"));

      // fix limitations on old android devices
      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      // all from documentation
      final cachebase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cachebase;

      return NativeDatabase.createInBackground(file);
    });

    return lazyDatabase;
  }
}




  ------
  1. now need to create a database wrapper
  1. so we can have it easier for tests later
  2. goal is to have some kind of interface around database
  - to which we can later pass other query executroes 
  - query executor is what we just created now


  import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/drift_app_database/drift_app_database.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/query_executors/sqlite_query_executor.dart';

class DriftDatabaseWrapper {
  DriftDatabaseWrapper(this._executor);

  final QueryExecutor _executor;

  factory DriftDatabaseWrapper.app() {
    return DriftDatabaseWrapper(SqliteQueryExecutor().executor);
  }

  DriftAppDatabase? _database;

  DriftAppDatabase get database {
    final initializedDatabase = _database;
    if (initializedDatabase == null) {
      throw Exception("Database not initialized");
    }

    return initializedDatabase;
  }

  Future<void> initialize() async {
    try {
      final database = DriftAppDatabase(_executor);

      final currentTime = database.current_timestamp();
      log("Current time: $currentTime");

      _database = database;
    } catch (e) {
      log("Error initializing database: $e");
      rethrow;
    }
  }

  // TODO dont forget that drfit is supported by dev tools
  // https://drift.simonbinder.eu/docs/community_tools/#drift_db_viewer

  Future<T> runInTransaction<T>(
    Future<T> Function() action, {
    bool requireNew = false,
  }) async {
    return database.transaction(action, requireNew: requireNew);
  }

  Future runInBatch(
    void Function(Batch batch) action,
  ) async {
    await database.batch(action);
  }

  Future<void> close() async {
    await database.close();
  }
}

1. now create first migration
- just to havde vdeersion 1
- run makefile migration commands

1. now create table
   1. for period daily budget for period
   2. no need for any references 
   3. fields are 
      1. id
      2. period start date
      3. period end date
      4. budget amount
      5. period type - some enum
         1. week
         2. month
         3. year
         4. day
      6. created 
      7. updated  
   4. we need unique key
      1. period start date 
      2. period end date 
   5. we will create this as a feature
      1. period daily budget
      2. that means that we would have data source local
         1. get period daily budget 
         2. store period daily budget

import 'package:drift/drift.dart';

class PeriodDailyBudgetLocalEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get periodStart => dateTime()();
  DateTimeColumn get periodEnd => dateTime()();
  IntColumn get amount => integer()();
  IntColumn get period => intEnum<Period>()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
        {
          periodStart,
          periodEnd,
        }
      ];
}

enum Period {
  year, // 0
  month, // 1
  week, // 2
  day, // 3
}





2. and now need to setup and do migration
- add table to database
- increase schema version
- run commands from readme
- add new migration to migrator


import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/wrappers/drift/migrations/schema_versions/schema_versions.dart';

class DriftAppDatabaseMigrator {
  final MigrationStrategy migrationStrategy = MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      // SOME POPULATE THINGS IF NEEDED
    },
    // TODO this will be generated for us
    // onUpgrade: (m, from, to) async {
    //   // SOME MIGRATIONS IF NEEDED
    // },
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.createTable(schema.periodDailyBudgetLocalEntity);
      },
    ),
  );
}

3. now need to add test database
- we will have a new wrapper for that
- to make sure we can do crazy stuff


import 'package:svorc_proto_v1/src/wrappers/drift/drift_database_wrapper.dart';

class TestDatabaseWrapper {
  TestDatabaseWrapper(this._databaseWrapper);

  final DriftDatabaseWrapper _databaseWrapper;
  DriftDatabaseWrapper get databaseWrapper => _databaseWrapper;

  static TestDatabaseWrapper getInitializedTestDatabaseWrapper() {
    final databaseWrapper = DriftDatabaseWrapper(
      NativeDatabase.memory(),
    );
    databaseWrapper.initialize();

    final testDatabaseWrapper = TestDatabaseWrapper(databaseWrapper);

    return testDatabaseWrapper;
  }
}


4. now lets write a data source for this
- for now we have 
- store
- get 

- and we will create value objects 
- we dont want to depend on data returned by the tool


5. ok, now we want to insert some categories into db initially
- for this, we first have to create the whole category table
- it would have only fiew fields 
  - id 
  - name - this can be unique
  - created
  - updated
- and then we want to create a migration for this
- and then we want to crete "general" category initially when the app first runs
- but we only want to insert this if it does not exist - so we basically want to upsert 

- ok, we will make this as a categories feature - or should it be core. because cateogries are core to the app. lets make it its own feature

- ok, we now need to insert data into database on database start

- for this, we need to rework the migrator
- it needs to accept database
- we need to make fields lazy late initialized 
- and we then insert data in

  Future<void> _onBeforeOpen(OpeningDetails details) async {
    // SOME POPULATE THINGS IF NEEDED
    // _database

    final generalCategoryCompanion = CategoryLocalEntityCompanion.insert(
      name: "general",
    );

    // await _database
    //     .into(_database.categoryLocalEntity)
    //     .insertOnConflictUpdate(
    //       generalCategoryCompanion,
    //     );

    await _database.categoryLocalEntity.insertOne(
      generalCategoryCompanion,
      onConflict: DoNothing(),
    );
  }