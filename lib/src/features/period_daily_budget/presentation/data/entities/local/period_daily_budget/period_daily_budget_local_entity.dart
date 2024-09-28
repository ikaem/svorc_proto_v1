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
