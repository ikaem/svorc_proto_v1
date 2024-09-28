import 'package:drift/native.dart';
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
