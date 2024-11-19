// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_month_balances_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCurrentMonthBalancesControllerHash() =>
    r'f5becf48735fdd3e080809f36f5c0a25dd7046f4';

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

abstract class _$GetCurrentMonthBalancesController
    extends BuildlessAutoDisposeAsyncNotifier<
        GetCurrentMonthBalancesControllerStateData> {
  late final PeriodDailyBudgetModel currentMonthDailyBudget;

  FutureOr<GetCurrentMonthBalancesControllerStateData> build(
    PeriodDailyBudgetModel currentMonthDailyBudget,
  );
}

/// See also [GetCurrentMonthBalancesController].
@ProviderFor(GetCurrentMonthBalancesController)
const getCurrentMonthBalancesControllerProvider =
    GetCurrentMonthBalancesControllerFamily();

/// See also [GetCurrentMonthBalancesController].
class GetCurrentMonthBalancesControllerFamily
    extends Family<AsyncValue<GetCurrentMonthBalancesControllerStateData>> {
  /// See also [GetCurrentMonthBalancesController].
  const GetCurrentMonthBalancesControllerFamily();

  /// See also [GetCurrentMonthBalancesController].
  GetCurrentMonthBalancesControllerProvider call(
    PeriodDailyBudgetModel currentMonthDailyBudget,
  ) {
    return GetCurrentMonthBalancesControllerProvider(
      currentMonthDailyBudget,
    );
  }

  @override
  GetCurrentMonthBalancesControllerProvider getProviderOverride(
    covariant GetCurrentMonthBalancesControllerProvider provider,
  ) {
    return call(
      provider.currentMonthDailyBudget,
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
  String? get name => r'getCurrentMonthBalancesControllerProvider';
}

/// See also [GetCurrentMonthBalancesController].
class GetCurrentMonthBalancesControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        GetCurrentMonthBalancesController,
        GetCurrentMonthBalancesControllerStateData> {
  /// See also [GetCurrentMonthBalancesController].
  GetCurrentMonthBalancesControllerProvider(
    PeriodDailyBudgetModel currentMonthDailyBudget,
  ) : this._internal(
          () => GetCurrentMonthBalancesController()
            ..currentMonthDailyBudget = currentMonthDailyBudget,
          from: getCurrentMonthBalancesControllerProvider,
          name: r'getCurrentMonthBalancesControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCurrentMonthBalancesControllerHash,
          dependencies: GetCurrentMonthBalancesControllerFamily._dependencies,
          allTransitiveDependencies: GetCurrentMonthBalancesControllerFamily
              ._allTransitiveDependencies,
          currentMonthDailyBudget: currentMonthDailyBudget,
        );

  GetCurrentMonthBalancesControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.currentMonthDailyBudget,
  }) : super.internal();

  final PeriodDailyBudgetModel currentMonthDailyBudget;

  @override
  FutureOr<GetCurrentMonthBalancesControllerStateData> runNotifierBuild(
    covariant GetCurrentMonthBalancesController notifier,
  ) {
    return notifier.build(
      currentMonthDailyBudget,
    );
  }

  @override
  Override overrideWith(GetCurrentMonthBalancesController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetCurrentMonthBalancesControllerProvider._internal(
        () => create()..currentMonthDailyBudget = currentMonthDailyBudget,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        currentMonthDailyBudget: currentMonthDailyBudget,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetCurrentMonthBalancesController,
      GetCurrentMonthBalancesControllerStateData> createElement() {
    return _GetCurrentMonthBalancesControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCurrentMonthBalancesControllerProvider &&
        other.currentMonthDailyBudget == currentMonthDailyBudget;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currentMonthDailyBudget.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetCurrentMonthBalancesControllerRef
    on AutoDisposeAsyncNotifierProviderRef<
        GetCurrentMonthBalancesControllerStateData> {
  /// The parameter `currentMonthDailyBudget` of this provider.
  PeriodDailyBudgetModel get currentMonthDailyBudget;
}

class _GetCurrentMonthBalancesControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        GetCurrentMonthBalancesController,
        GetCurrentMonthBalancesControllerStateData>
    with GetCurrentMonthBalancesControllerRef {
  _GetCurrentMonthBalancesControllerProviderElement(super.provider);

  @override
  PeriodDailyBudgetModel get currentMonthDailyBudget =>
      (origin as GetCurrentMonthBalancesControllerProvider)
          .currentMonthDailyBudget;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
