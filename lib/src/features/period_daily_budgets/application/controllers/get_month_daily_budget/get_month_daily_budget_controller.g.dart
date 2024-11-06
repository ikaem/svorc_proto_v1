// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_month_daily_budget_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMonthDailyBudgetControllerHash() =>
    r'fad116b3564caa75a229f22e48a82e154e8f9b7f';

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

abstract class _$GetMonthDailyBudgetController
    extends BuildlessAutoDisposeAsyncNotifier<
        GetMonthDailyBudgetControllerState> {
  late final DateTime date;

  FutureOr<GetMonthDailyBudgetControllerState> build(
    DateTime date,
  );
}

/// See also [GetMonthDailyBudgetController].
@ProviderFor(GetMonthDailyBudgetController)
const getMonthDailyBudgetControllerProvider =
    GetMonthDailyBudgetControllerFamily();

/// See also [GetMonthDailyBudgetController].
class GetMonthDailyBudgetControllerFamily
    extends Family<AsyncValue<GetMonthDailyBudgetControllerState>> {
  /// See also [GetMonthDailyBudgetController].
  const GetMonthDailyBudgetControllerFamily();

  /// See also [GetMonthDailyBudgetController].
  GetMonthDailyBudgetControllerProvider call(
    DateTime date,
  ) {
    return GetMonthDailyBudgetControllerProvider(
      date,
    );
  }

  @override
  GetMonthDailyBudgetControllerProvider getProviderOverride(
    covariant GetMonthDailyBudgetControllerProvider provider,
  ) {
    return call(
      provider.date,
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
  String? get name => r'getMonthDailyBudgetControllerProvider';
}

/// See also [GetMonthDailyBudgetController].
class GetMonthDailyBudgetControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetMonthDailyBudgetController,
        GetMonthDailyBudgetControllerState> {
  /// See also [GetMonthDailyBudgetController].
  GetMonthDailyBudgetControllerProvider(
    DateTime date,
  ) : this._internal(
          () => GetMonthDailyBudgetController()..date = date,
          from: getMonthDailyBudgetControllerProvider,
          name: r'getMonthDailyBudgetControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMonthDailyBudgetControllerHash,
          dependencies: GetMonthDailyBudgetControllerFamily._dependencies,
          allTransitiveDependencies:
              GetMonthDailyBudgetControllerFamily._allTransitiveDependencies,
          date: date,
        );

  GetMonthDailyBudgetControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  FutureOr<GetMonthDailyBudgetControllerState> runNotifierBuild(
    covariant GetMonthDailyBudgetController notifier,
  ) {
    return notifier.build(
      date,
    );
  }

  @override
  Override overrideWith(GetMonthDailyBudgetController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetMonthDailyBudgetControllerProvider._internal(
        () => create()..date = date,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetMonthDailyBudgetController,
      GetMonthDailyBudgetControllerState> createElement() {
    return _GetMonthDailyBudgetControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMonthDailyBudgetControllerProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetMonthDailyBudgetControllerRef
    on AutoDisposeAsyncNotifierProviderRef<GetMonthDailyBudgetControllerState> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _GetMonthDailyBudgetControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        GetMonthDailyBudgetController, GetMonthDailyBudgetControllerState>
    with GetMonthDailyBudgetControllerRef {
  _GetMonthDailyBudgetControllerProviderElement(super.provider);

  @override
  DateTime get date => (origin as GetMonthDailyBudgetControllerProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
