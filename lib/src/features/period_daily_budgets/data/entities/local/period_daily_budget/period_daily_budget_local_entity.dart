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

// TODO move this somewhere, and make this a what? model? Value? some kind of constant? entity? Think about it?
// PeriodSingle PeriodUnit? So maybe units? or some kind of indicator? or identifier?
enum Period {
  year, // 0
  month, // 1
  week, // 2
  day, // 3
}
