import 'package:drift/drift.dart';

class CategoryLocalEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
