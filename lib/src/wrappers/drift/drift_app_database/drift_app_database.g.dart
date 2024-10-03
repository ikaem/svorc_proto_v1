// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_app_database.dart';

// ignore_for_file: type=lint
class $PeriodDailyBudgetLocalEntityTable extends PeriodDailyBudgetLocalEntity
    with
        TableInfo<$PeriodDailyBudgetLocalEntityTable,
            PeriodDailyBudgetLocalEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeriodDailyBudgetLocalEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _periodStartMeta =
      const VerificationMeta('periodStart');
  @override
  late final GeneratedColumn<DateTime> periodStart = GeneratedColumn<DateTime>(
      'period_start', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _periodEndMeta =
      const VerificationMeta('periodEnd');
  @override
  late final GeneratedColumn<DateTime> periodEnd = GeneratedColumn<DateTime>(
      'period_end', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumnWithTypeConverter<Period, int> period =
      GeneratedColumn<int>('period', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Period>(
              $PeriodDailyBudgetLocalEntityTable.$converterperiod);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, periodStart, periodEnd, amount, period, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'period_daily_budget_local_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<PeriodDailyBudgetLocalEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('period_start')) {
      context.handle(
          _periodStartMeta,
          periodStart.isAcceptableOrUnknown(
              data['period_start']!, _periodStartMeta));
    } else if (isInserting) {
      context.missing(_periodStartMeta);
    }
    if (data.containsKey('period_end')) {
      context.handle(_periodEndMeta,
          periodEnd.isAcceptableOrUnknown(data['period_end']!, _periodEndMeta));
    } else if (isInserting) {
      context.missing(_periodEndMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    context.handle(_periodMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {periodStart, periodEnd},
      ];
  @override
  PeriodDailyBudgetLocalEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeriodDailyBudgetLocalEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      periodStart: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}period_start'])!,
      periodEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}period_end'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      period: $PeriodDailyBudgetLocalEntityTable.$converterperiod.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}period'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PeriodDailyBudgetLocalEntityTable createAlias(String alias) {
    return $PeriodDailyBudgetLocalEntityTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Period, int, int> $converterperiod =
      const EnumIndexConverter<Period>(Period.values);
}

class PeriodDailyBudgetLocalEntityData extends DataClass
    implements Insertable<PeriodDailyBudgetLocalEntityData> {
  final int id;
  final DateTime periodStart;
  final DateTime periodEnd;
  final int amount;
  final Period period;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PeriodDailyBudgetLocalEntityData(
      {required this.id,
      required this.periodStart,
      required this.periodEnd,
      required this.amount,
      required this.period,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['period_start'] = Variable<DateTime>(periodStart);
    map['period_end'] = Variable<DateTime>(periodEnd);
    map['amount'] = Variable<int>(amount);
    {
      map['period'] = Variable<int>(
          $PeriodDailyBudgetLocalEntityTable.$converterperiod.toSql(period));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PeriodDailyBudgetLocalEntityCompanion toCompanion(bool nullToAbsent) {
    return PeriodDailyBudgetLocalEntityCompanion(
      id: Value(id),
      periodStart: Value(periodStart),
      periodEnd: Value(periodEnd),
      amount: Value(amount),
      period: Value(period),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PeriodDailyBudgetLocalEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeriodDailyBudgetLocalEntityData(
      id: serializer.fromJson<int>(json['id']),
      periodStart: serializer.fromJson<DateTime>(json['periodStart']),
      periodEnd: serializer.fromJson<DateTime>(json['periodEnd']),
      amount: serializer.fromJson<int>(json['amount']),
      period: $PeriodDailyBudgetLocalEntityTable.$converterperiod
          .fromJson(serializer.fromJson<int>(json['period'])),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'periodStart': serializer.toJson<DateTime>(periodStart),
      'periodEnd': serializer.toJson<DateTime>(periodEnd),
      'amount': serializer.toJson<int>(amount),
      'period': serializer.toJson<int>(
          $PeriodDailyBudgetLocalEntityTable.$converterperiod.toJson(period)),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PeriodDailyBudgetLocalEntityData copyWith(
          {int? id,
          DateTime? periodStart,
          DateTime? periodEnd,
          int? amount,
          Period? period,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PeriodDailyBudgetLocalEntityData(
        id: id ?? this.id,
        periodStart: periodStart ?? this.periodStart,
        periodEnd: periodEnd ?? this.periodEnd,
        amount: amount ?? this.amount,
        period: period ?? this.period,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PeriodDailyBudgetLocalEntityData copyWithCompanion(
      PeriodDailyBudgetLocalEntityCompanion data) {
    return PeriodDailyBudgetLocalEntityData(
      id: data.id.present ? data.id.value : this.id,
      periodStart:
          data.periodStart.present ? data.periodStart.value : this.periodStart,
      periodEnd: data.periodEnd.present ? data.periodEnd.value : this.periodEnd,
      amount: data.amount.present ? data.amount.value : this.amount,
      period: data.period.present ? data.period.value : this.period,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeriodDailyBudgetLocalEntityData(')
          ..write('id: $id, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('amount: $amount, ')
          ..write('period: $period, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, periodStart, periodEnd, amount, period, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeriodDailyBudgetLocalEntityData &&
          other.id == this.id &&
          other.periodStart == this.periodStart &&
          other.periodEnd == this.periodEnd &&
          other.amount == this.amount &&
          other.period == this.period &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PeriodDailyBudgetLocalEntityCompanion
    extends UpdateCompanion<PeriodDailyBudgetLocalEntityData> {
  final Value<int> id;
  final Value<DateTime> periodStart;
  final Value<DateTime> periodEnd;
  final Value<int> amount;
  final Value<Period> period;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PeriodDailyBudgetLocalEntityCompanion({
    this.id = const Value.absent(),
    this.periodStart = const Value.absent(),
    this.periodEnd = const Value.absent(),
    this.amount = const Value.absent(),
    this.period = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PeriodDailyBudgetLocalEntityCompanion.insert({
    this.id = const Value.absent(),
    required DateTime periodStart,
    required DateTime periodEnd,
    required int amount,
    required Period period,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : periodStart = Value(periodStart),
        periodEnd = Value(periodEnd),
        amount = Value(amount),
        period = Value(period);
  static Insertable<PeriodDailyBudgetLocalEntityData> custom({
    Expression<int>? id,
    Expression<DateTime>? periodStart,
    Expression<DateTime>? periodEnd,
    Expression<int>? amount,
    Expression<int>? period,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (periodStart != null) 'period_start': periodStart,
      if (periodEnd != null) 'period_end': periodEnd,
      if (amount != null) 'amount': amount,
      if (period != null) 'period': period,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PeriodDailyBudgetLocalEntityCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? periodStart,
      Value<DateTime>? periodEnd,
      Value<int>? amount,
      Value<Period>? period,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PeriodDailyBudgetLocalEntityCompanion(
      id: id ?? this.id,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      amount: amount ?? this.amount,
      period: period ?? this.period,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (periodStart.present) {
      map['period_start'] = Variable<DateTime>(periodStart.value);
    }
    if (periodEnd.present) {
      map['period_end'] = Variable<DateTime>(periodEnd.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (period.present) {
      map['period'] = Variable<int>($PeriodDailyBudgetLocalEntityTable
          .$converterperiod
          .toSql(period.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeriodDailyBudgetLocalEntityCompanion(')
          ..write('id: $id, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('amount: $amount, ')
          ..write('period: $period, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CategoryLocalEntityTable extends CategoryLocalEntity
    with TableInfo<$CategoryLocalEntityTable, CategoryLocalEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryLocalEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_local_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<CategoryLocalEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryLocalEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryLocalEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CategoryLocalEntityTable createAlias(String alias) {
    return $CategoryLocalEntityTable(attachedDatabase, alias);
  }
}

class CategoryLocalEntityData extends DataClass
    implements Insertable<CategoryLocalEntityData> {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CategoryLocalEntityData(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoryLocalEntityCompanion toCompanion(bool nullToAbsent) {
    return CategoryLocalEntityCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoryLocalEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryLocalEntityData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoryLocalEntityData copyWith(
          {int? id, String? name, DateTime? createdAt, DateTime? updatedAt}) =>
      CategoryLocalEntityData(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CategoryLocalEntityData copyWithCompanion(CategoryLocalEntityCompanion data) {
    return CategoryLocalEntityData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryLocalEntityData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryLocalEntityData &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoryLocalEntityCompanion
    extends UpdateCompanion<CategoryLocalEntityData> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CategoryLocalEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CategoryLocalEntityCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<CategoryLocalEntityData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CategoryLocalEntityCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return CategoryLocalEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryLocalEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftAppDatabase extends GeneratedDatabase {
  _$DriftAppDatabase(QueryExecutor e) : super(e);
  $DriftAppDatabaseManager get managers => $DriftAppDatabaseManager(this);
  late final $PeriodDailyBudgetLocalEntityTable periodDailyBudgetLocalEntity =
      $PeriodDailyBudgetLocalEntityTable(this);
  late final $CategoryLocalEntityTable categoryLocalEntity =
      $CategoryLocalEntityTable(this);
  Selectable<String> current_timestamp() {
    return customSelect('SELECT CURRENT_TIMESTAMP AS _c0',
        variables: [],
        readsFrom: {}).map((QueryRow row) => row.read<String>('_c0'));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [periodDailyBudgetLocalEntity, categoryLocalEntity];
}

typedef $$PeriodDailyBudgetLocalEntityTableCreateCompanionBuilder
    = PeriodDailyBudgetLocalEntityCompanion Function({
  Value<int> id,
  required DateTime periodStart,
  required DateTime periodEnd,
  required int amount,
  required Period period,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PeriodDailyBudgetLocalEntityTableUpdateCompanionBuilder
    = PeriodDailyBudgetLocalEntityCompanion Function({
  Value<int> id,
  Value<DateTime> periodStart,
  Value<DateTime> periodEnd,
  Value<int> amount,
  Value<Period> period,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$PeriodDailyBudgetLocalEntityTableFilterComposer extends FilterComposer<
    _$DriftAppDatabase, $PeriodDailyBudgetLocalEntityTable> {
  $$PeriodDailyBudgetLocalEntityTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get periodStart => $state.composableBuilder(
      column: $state.table.periodStart,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get periodEnd => $state.composableBuilder(
      column: $state.table.periodEnd,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<Period, Period, int> get period =>
      $state.composableBuilder(
          column: $state.table.period,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$PeriodDailyBudgetLocalEntityTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase,
        $PeriodDailyBudgetLocalEntityTable> {
  $$PeriodDailyBudgetLocalEntityTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get periodStart => $state.composableBuilder(
      column: $state.table.periodStart,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get periodEnd => $state.composableBuilder(
      column: $state.table.periodEnd,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get period => $state.composableBuilder(
      column: $state.table.period,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$PeriodDailyBudgetLocalEntityTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $PeriodDailyBudgetLocalEntityTable,
    PeriodDailyBudgetLocalEntityData,
    $$PeriodDailyBudgetLocalEntityTableFilterComposer,
    $$PeriodDailyBudgetLocalEntityTableOrderingComposer,
    $$PeriodDailyBudgetLocalEntityTableCreateCompanionBuilder,
    $$PeriodDailyBudgetLocalEntityTableUpdateCompanionBuilder,
    (
      PeriodDailyBudgetLocalEntityData,
      BaseReferences<_$DriftAppDatabase, $PeriodDailyBudgetLocalEntityTable,
          PeriodDailyBudgetLocalEntityData>
    ),
    PeriodDailyBudgetLocalEntityData,
    PrefetchHooks Function()> {
  $$PeriodDailyBudgetLocalEntityTableTableManager(
      _$DriftAppDatabase db, $PeriodDailyBudgetLocalEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$PeriodDailyBudgetLocalEntityTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$PeriodDailyBudgetLocalEntityTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> periodStart = const Value.absent(),
            Value<DateTime> periodEnd = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<Period> period = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PeriodDailyBudgetLocalEntityCompanion(
            id: id,
            periodStart: periodStart,
            periodEnd: periodEnd,
            amount: amount,
            period: period,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime periodStart,
            required DateTime periodEnd,
            required int amount,
            required Period period,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PeriodDailyBudgetLocalEntityCompanion.insert(
            id: id,
            periodStart: periodStart,
            periodEnd: periodEnd,
            amount: amount,
            period: period,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PeriodDailyBudgetLocalEntityTableProcessedTableManager
    = ProcessedTableManager<
        _$DriftAppDatabase,
        $PeriodDailyBudgetLocalEntityTable,
        PeriodDailyBudgetLocalEntityData,
        $$PeriodDailyBudgetLocalEntityTableFilterComposer,
        $$PeriodDailyBudgetLocalEntityTableOrderingComposer,
        $$PeriodDailyBudgetLocalEntityTableCreateCompanionBuilder,
        $$PeriodDailyBudgetLocalEntityTableUpdateCompanionBuilder,
        (
          PeriodDailyBudgetLocalEntityData,
          BaseReferences<_$DriftAppDatabase, $PeriodDailyBudgetLocalEntityTable,
              PeriodDailyBudgetLocalEntityData>
        ),
        PeriodDailyBudgetLocalEntityData,
        PrefetchHooks Function()>;
typedef $$CategoryLocalEntityTableCreateCompanionBuilder
    = CategoryLocalEntityCompanion Function({
  Value<int> id,
  required String name,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$CategoryLocalEntityTableUpdateCompanionBuilder
    = CategoryLocalEntityCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$CategoryLocalEntityTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $CategoryLocalEntityTable> {
  $$CategoryLocalEntityTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CategoryLocalEntityTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $CategoryLocalEntityTable> {
  $$CategoryLocalEntityTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$CategoryLocalEntityTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $CategoryLocalEntityTable,
    CategoryLocalEntityData,
    $$CategoryLocalEntityTableFilterComposer,
    $$CategoryLocalEntityTableOrderingComposer,
    $$CategoryLocalEntityTableCreateCompanionBuilder,
    $$CategoryLocalEntityTableUpdateCompanionBuilder,
    (
      CategoryLocalEntityData,
      BaseReferences<_$DriftAppDatabase, $CategoryLocalEntityTable,
          CategoryLocalEntityData>
    ),
    CategoryLocalEntityData,
    PrefetchHooks Function()> {
  $$CategoryLocalEntityTableTableManager(
      _$DriftAppDatabase db, $CategoryLocalEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$CategoryLocalEntityTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$CategoryLocalEntityTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CategoryLocalEntityCompanion(
            id: id,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CategoryLocalEntityCompanion.insert(
            id: id,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoryLocalEntityTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $CategoryLocalEntityTable,
    CategoryLocalEntityData,
    $$CategoryLocalEntityTableFilterComposer,
    $$CategoryLocalEntityTableOrderingComposer,
    $$CategoryLocalEntityTableCreateCompanionBuilder,
    $$CategoryLocalEntityTableUpdateCompanionBuilder,
    (
      CategoryLocalEntityData,
      BaseReferences<_$DriftAppDatabase, $CategoryLocalEntityTable,
          CategoryLocalEntityData>
    ),
    CategoryLocalEntityData,
    PrefetchHooks Function()>;

class $DriftAppDatabaseManager {
  final _$DriftAppDatabase _db;
  $DriftAppDatabaseManager(this._db);
  $$PeriodDailyBudgetLocalEntityTableTableManager
      get periodDailyBudgetLocalEntity =>
          $$PeriodDailyBudgetLocalEntityTableTableManager(
              _db, _db.periodDailyBudgetLocalEntity);
  $$CategoryLocalEntityTableTableManager get categoryLocalEntity =>
      $$CategoryLocalEntityTableTableManager(_db, _db.categoryLocalEntity);
}
