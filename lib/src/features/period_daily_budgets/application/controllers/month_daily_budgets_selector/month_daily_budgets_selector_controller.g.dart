// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_daily_budgets_selector_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$monthDailyBudgetsSelectorControllerHash() =>
    r'5d7eb1cb5b4e65b15a063dfd3513903f29534c7a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MonthDailyBudgetsSelectorController
    extends BuildlessAutoDisposeNotifier<
        MonthDailyBudgetsSelectorControllerStateData> {
  late final List<PeriodDailyBudgetModel> budgets;

  MonthDailyBudgetsSelectorControllerStateData build(
    List<PeriodDailyBudgetModel> budgets,
  );
}

/// See also [MonthDailyBudgetsSelectorController].
@ProviderFor(MonthDailyBudgetsSelectorController)
const monthDailyBudgetsSelectorControllerProvider =
    MonthDailyBudgetsSelectorControllerFamily();

/// See also [MonthDailyBudgetsSelectorController].
class MonthDailyBudgetsSelectorControllerFamily
    extends Family<MonthDailyBudgetsSelectorControllerStateData> {
  /// See also [MonthDailyBudgetsSelectorController].
  const MonthDailyBudgetsSelectorControllerFamily();

  /// See also [MonthDailyBudgetsSelectorController].
  MonthDailyBudgetsSelectorControllerProvider call(
    List<PeriodDailyBudgetModel> budgets,
  ) {
    return MonthDailyBudgetsSelectorControllerProvider(
      budgets,
    );
  }

  @override
  MonthDailyBudgetsSelectorControllerProvider getProviderOverride(
    covariant MonthDailyBudgetsSelectorControllerProvider provider,
  ) {
    return call(
      provider.budgets,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'monthDailyBudgetsSelectorControllerProvider';
}

/// See also [MonthDailyBudgetsSelectorController].
class MonthDailyBudgetsSelectorControllerProvider
    extends AutoDisposeNotifierProviderImpl<MonthDailyBudgetsSelectorController,
        MonthDailyBudgetsSelectorControllerStateData> {
  /// See also [MonthDailyBudgetsSelectorController].
  MonthDailyBudgetsSelectorControllerProvider(
    List<PeriodDailyBudgetModel> budgets,
  ) : this._internal(
          () => MonthDailyBudgetsSelectorController()..budgets = budgets,
          from: monthDailyBudgetsSelectorControllerProvider,
          name: r'monthDailyBudgetsSelectorControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monthDailyBudgetsSelectorControllerHash,
          dependencies: MonthDailyBudgetsSelectorControllerFamily._dependencies,
          allTransitiveDependencies: MonthDailyBudgetsSelectorControllerFamily
              ._allTransitiveDependencies,
          budgets: budgets,
        );

  MonthDailyBudgetsSelectorControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.budgets,
  }) : super.internal();

  final List<PeriodDailyBudgetModel> budgets;

  @override
  MonthDailyBudgetsSelectorControllerStateData runNotifierBuild(
    covariant MonthDailyBudgetsSelectorController notifier,
  ) {
    return notifier.build(
      budgets,
    );
  }

  @override
  Override overrideWith(MonthDailyBudgetsSelectorController Function() create) {
    return ProviderOverride(
      origin: this,
      override: MonthDailyBudgetsSelectorControllerProvider._internal(
        () => create()..budgets = budgets,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        budgets: budgets,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<MonthDailyBudgetsSelectorController,
      MonthDailyBudgetsSelectorControllerStateData> createElement() {
    return _MonthDailyBudgetsSelectorControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthDailyBudgetsSelectorControllerProvider &&
        other.budgets == budgets;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, budgets.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MonthDailyBudgetsSelectorControllerRef on AutoDisposeNotifierProviderRef<
    MonthDailyBudgetsSelectorControllerStateData> {
  /// The parameter `budgets` of this provider.
  List<PeriodDailyBudgetModel> get budgets;
}

class _MonthDailyBudgetsSelectorControllerProviderElement
    extends AutoDisposeNotifierProviderElement<
        MonthDailyBudgetsSelectorController,
        MonthDailyBudgetsSelectorControllerStateData>
    with MonthDailyBudgetsSelectorControllerRef {
  _MonthDailyBudgetsSelectorControllerProviderElement(super.provider);

  @override
  List<PeriodDailyBudgetModel> get budgets =>
      (origin as MonthDailyBudgetsSelectorControllerProvider).budgets;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
