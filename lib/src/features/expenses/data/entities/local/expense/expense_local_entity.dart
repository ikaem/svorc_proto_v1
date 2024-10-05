import 'package:drift/drift.dart';
import 'package:svorc_proto_v1/src/features/categories/data/entities/local/category/category_local_entity.dart';

class ExpenseLocalEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get amount => integer()();
  TextColumn get note => text().nullable()();
  IntColumn get categoryId => integer().references(CategoryLocalEntity, #id)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
