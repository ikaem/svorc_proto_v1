// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_month_daily_budget_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setMonthDailyBudgetControllerHash() =>
    r'6c0762cd1a2fdd83936e2dbddbd8b5abd97c542c';

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

abstract class _$SetMonthDailyBudgetController
    extends BuildlessAutoDisposeNotifier<
        SetMonthDailyBudgetControllerStateData> {
  late final List<PeriodDailyBudgetModel> budgets;

  SetMonthDailyBudgetControllerStateData build(
    List<PeriodDailyBudgetModel> budgets,
  );
}

/// See also [SetMonthDailyBudgetController].
@ProviderFor(SetMonthDailyBudgetController)
const setMonthDailyBudgetControllerProvider =
    SetMonthDailyBudgetControllerFamily();

/// See also [SetMonthDailyBudgetController].
class SetMonthDailyBudgetControllerFamily
    extends Family<SetMonthDailyBudgetControllerStateData> {
  /// See also [SetMonthDailyBudgetController].
  const SetMonthDailyBudgetControllerFamily();

  /// See also [SetMonthDailyBudgetController].
  SetMonthDailyBudgetControllerProvider call(
    List<PeriodDailyBudgetModel> budgets,
  ) {
    return SetMonthDailyBudgetControllerProvider(
      budgets,
    );
  }

  @override
  SetMonthDailyBudgetControllerProvider getProviderOverride(
    covariant SetMonthDailyBudgetControllerProvider provider,
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
  String? get name => r'setMonthDailyBudgetControllerProvider';
}

/// See also [SetMonthDailyBudgetController].
class SetMonthDailyBudgetControllerProvider
    extends AutoDisposeNotifierProviderImpl<SetMonthDailyBudgetController,
        SetMonthDailyBudgetControllerStateData> {
  /// See also [SetMonthDailyBudgetController].
  SetMonthDailyBudgetControllerProvider(
    List<PeriodDailyBudgetModel> budgets,
  ) : this._internal(
          () => SetMonthDailyBudgetController()..budgets = budgets,
          from: setMonthDailyBudgetControllerProvider,
          name: r'setMonthDailyBudgetControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setMonthDailyBudgetControllerHash,
          dependencies: SetMonthDailyBudgetControllerFamily._dependencies,
          allTransitiveDependencies:
              SetMonthDailyBudgetControllerFamily._allTransitiveDependencies,
          budgets: budgets,
        );

  SetMonthDailyBudgetControllerProvider._internal(
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
  SetMonthDailyBudgetControllerStateData runNotifierBuild(
    covariant SetMonthDailyBudgetController notifier,
  ) {
    return notifier.build(
      budgets,
    );
  }

  @override
  Override overrideWith(SetMonthDailyBudgetController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SetMonthDailyBudgetControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<SetMonthDailyBudgetController,
      SetMonthDailyBudgetControllerStateData> createElement() {
    return _SetMonthDailyBudgetControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetMonthDailyBudgetControllerProvider &&
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
mixin SetMonthDailyBudgetControllerRef
    on AutoDisposeNotifierProviderRef<SetMonthDailyBudgetControllerStateData> {
  /// The parameter `budgets` of this provider.
  List<PeriodDailyBudgetModel> get budgets;
}

class _SetMonthDailyBudgetControllerProviderElement
    extends AutoDisposeNotifierProviderElement<SetMonthDailyBudgetController,
        SetMonthDailyBudgetControllerStateData>
    with SetMonthDailyBudgetControllerRef {
  _SetMonthDailyBudgetControllerProviderElement(super.provider);

  @override
  List<PeriodDailyBudgetModel> get budgets =>
      (origin as SetMonthDailyBudgetControllerProvider).budgets;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
