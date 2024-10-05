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

class $ExpenseLocalEntityTable extends ExpenseLocalEntity
    with TableInfo<$ExpenseLocalEntityTable, ExpenseLocalEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseLocalEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES category_local_entity (id)'));
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
      [id, date, amount, note, categoryId, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_local_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<ExpenseLocalEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
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
  ExpenseLocalEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseLocalEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ExpenseLocalEntityTable createAlias(String alias) {
    return $ExpenseLocalEntityTable(attachedDatabase, alias);
  }
}

class ExpenseLocalEntityData extends DataClass
    implements Insertable<ExpenseLocalEntityData> {
  final int id;
  final DateTime date;
  final int amount;
  final String? note;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ExpenseLocalEntityData(
      {required this.id,
      required this.date,
      required this.amount,
      this.note,
      required this.categoryId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['category_id'] = Variable<int>(categoryId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExpenseLocalEntityCompanion toCompanion(bool nullToAbsent) {
    return ExpenseLocalEntityCompanion(
      id: Value(id),
      date: Value(date),
      amount: Value(amount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      categoryId: Value(categoryId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExpenseLocalEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseLocalEntityData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<int>(json['amount']),
      note: serializer.fromJson<String?>(json['note']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<int>(amount),
      'note': serializer.toJson<String?>(note),
      'categoryId': serializer.toJson<int>(categoryId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExpenseLocalEntityData copyWith(
          {int? id,
          DateTime? date,
          int? amount,
          Value<String?> note = const Value.absent(),
          int? categoryId,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ExpenseLocalEntityData(
        id: id ?? this.id,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        note: note.present ? note.value : this.note,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ExpenseLocalEntityData copyWithCompanion(ExpenseLocalEntityCompanion data) {
    return ExpenseLocalEntityData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
      note: data.note.present ? data.note.value : this.note,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseLocalEntityData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('categoryId: $categoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, amount, note, categoryId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseLocalEntityData &&
          other.id == this.id &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.note == this.note &&
          other.categoryId == this.categoryId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExpenseLocalEntityCompanion
    extends UpdateCompanion<ExpenseLocalEntityData> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> amount;
  final Value<String?> note;
  final Value<int> categoryId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ExpenseLocalEntityCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ExpenseLocalEntityCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int amount,
    this.note = const Value.absent(),
    required int categoryId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : date = Value(date),
        amount = Value(amount),
        categoryId = Value(categoryId);
  static Insertable<ExpenseLocalEntityData> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? amount,
    Expression<String>? note,
    Expression<int>? categoryId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
      if (categoryId != null) 'category_id': categoryId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ExpenseLocalEntityCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<int>? amount,
      Value<String?>? note,
      Value<int>? categoryId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ExpenseLocalEntityCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      categoryId: categoryId ?? this.categoryId,
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
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
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
    return (StringBuffer('ExpenseLocalEntityCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('categoryId: $categoryId, ')
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
  late final $ExpenseLocalEntityTable expenseLocalEntity =
      $ExpenseLocalEntityTable(this);
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
      [periodDailyBudgetLocalEntity, categoryLocalEntity, expenseLocalEntity];
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

final class $$CategoryLocalEntityTableReferences extends BaseReferences<
    _$DriftAppDatabase, $CategoryLocalEntityTable, CategoryLocalEntityData> {
  $$CategoryLocalEntityTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExpenseLocalEntityTable,
      List<ExpenseLocalEntityData>> _expenseLocalEntityRefsTable(
          _$DriftAppDatabase db) =>
      MultiTypedResultKey.fromTable(db.expenseLocalEntity,
          aliasName: $_aliasNameGenerator(
              db.categoryLocalEntity.id, db.expenseLocalEntity.categoryId));

  $$ExpenseLocalEntityTableProcessedTableManager get expenseLocalEntityRefs {
    final manager =
        $$ExpenseLocalEntityTableTableManager($_db, $_db.expenseLocalEntity)
            .filter((f) => f.categoryId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_expenseLocalEntityRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

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

  ComposableFilter expenseLocalEntityRefs(
      ComposableFilter Function($$ExpenseLocalEntityTableFilterComposer f) f) {
    final $$ExpenseLocalEntityTableFilterComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.expenseLocalEntity,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder, parentComposers) =>
                $$ExpenseLocalEntityTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.expenseLocalEntity,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
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
    (CategoryLocalEntityData, $$CategoryLocalEntityTableReferences),
    CategoryLocalEntityData,
    PrefetchHooks Function({bool expenseLocalEntityRefs})> {
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
              .map((e) => (
                    e.readTable(table),
                    $$CategoryLocalEntityTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({expenseLocalEntityRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (expenseLocalEntityRefs) db.expenseLocalEntity
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (expenseLocalEntityRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CategoryLocalEntityTableReferences
                            ._expenseLocalEntityRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoryLocalEntityTableReferences(db, table, p0)
                                .expenseLocalEntityRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
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
    (CategoryLocalEntityData, $$CategoryLocalEntityTableReferences),
    CategoryLocalEntityData,
    PrefetchHooks Function({bool expenseLocalEntityRefs})>;
typedef $$ExpenseLocalEntityTableCreateCompanionBuilder
    = ExpenseLocalEntityCompanion Function({
  Value<int> id,
  required DateTime date,
  required int amount,
  Value<String?> note,
  required int categoryId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ExpenseLocalEntityTableUpdateCompanionBuilder
    = ExpenseLocalEntityCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<int> amount,
  Value<String?> note,
  Value<int> categoryId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ExpenseLocalEntityTableReferences extends BaseReferences<
    _$DriftAppDatabase, $ExpenseLocalEntityTable, ExpenseLocalEntityData> {
  $$ExpenseLocalEntityTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CategoryLocalEntityTable _categoryIdTable(_$DriftAppDatabase db) =>
      db.categoryLocalEntity.createAlias($_aliasNameGenerator(
          db.expenseLocalEntity.categoryId, db.categoryLocalEntity.id));

  $$CategoryLocalEntityTableProcessedTableManager? get categoryId {
    if ($_item.categoryId == null) return null;
    final manager =
        $$CategoryLocalEntityTableTableManager($_db, $_db.categoryLocalEntity)
            .filter((f) => f.id($_item.categoryId!));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExpenseLocalEntityTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $ExpenseLocalEntityTable> {
  $$ExpenseLocalEntityTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
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

  $$CategoryLocalEntityTableFilterComposer get categoryId {
    final $$CategoryLocalEntityTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $state.db.categoryLocalEntity,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CategoryLocalEntityTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.categoryLocalEntity,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$ExpenseLocalEntityTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $ExpenseLocalEntityTable> {
  $$ExpenseLocalEntityTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
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

  $$CategoryLocalEntityTableOrderingComposer get categoryId {
    final $$CategoryLocalEntityTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $state.db.categoryLocalEntity,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CategoryLocalEntityTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.categoryLocalEntity,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$ExpenseLocalEntityTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $ExpenseLocalEntityTable,
    ExpenseLocalEntityData,
    $$ExpenseLocalEntityTableFilterComposer,
    $$ExpenseLocalEntityTableOrderingComposer,
    $$ExpenseLocalEntityTableCreateCompanionBuilder,
    $$ExpenseLocalEntityTableUpdateCompanionBuilder,
    (ExpenseLocalEntityData, $$ExpenseLocalEntityTableReferences),
    ExpenseLocalEntityData,
    PrefetchHooks Function({bool categoryId})> {
  $$ExpenseLocalEntityTableTableManager(
      _$DriftAppDatabase db, $ExpenseLocalEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ExpenseLocalEntityTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$ExpenseLocalEntityTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ExpenseLocalEntityCompanion(
            id: id,
            date: date,
            amount: amount,
            note: note,
            categoryId: categoryId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required int amount,
            Value<String?> note = const Value.absent(),
            required int categoryId,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ExpenseLocalEntityCompanion.insert(
            id: id,
            date: date,
            amount: amount,
            note: note,
            categoryId: categoryId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExpenseLocalEntityTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable: $$ExpenseLocalEntityTableReferences
                        ._categoryIdTable(db),
                    referencedColumn: $$ExpenseLocalEntityTableReferences
                        ._categoryIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExpenseLocalEntityTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $ExpenseLocalEntityTable,
    ExpenseLocalEntityData,
    $$ExpenseLocalEntityTableFilterComposer,
    $$ExpenseLocalEntityTableOrderingComposer,
    $$ExpenseLocalEntityTableCreateCompanionBuilder,
    $$ExpenseLocalEntityTableUpdateCompanionBuilder,
    (ExpenseLocalEntityData, $$ExpenseLocalEntityTableReferences),
    ExpenseLocalEntityData,
    PrefetchHooks Function({bool categoryId})>;

class $DriftAppDatabaseManager {
  final _$DriftAppDatabase _db;
  $DriftAppDatabaseManager(this._db);
  $$PeriodDailyBudgetLocalEntityTableTableManager
      get periodDailyBudgetLocalEntity =>
          $$PeriodDailyBudgetLocalEntityTableTableManager(
              _db, _db.periodDailyBudgetLocalEntity);
  $$CategoryLocalEntityTableTableManager get categoryLocalEntity =>
      $$CategoryLocalEntityTableTableManager(_db, _db.categoryLocalEntity);
  $$ExpenseLocalEntityTableTableManager get expenseLocalEntity =>
      $$ExpenseLocalEntityTableTableManager(_db, _db.expenseLocalEntity);
}
