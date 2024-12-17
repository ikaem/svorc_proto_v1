import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/watch_recent_expenses_use_case.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

part 'watch_recent_expenses_controller_state_data.dart';
part "watch_recent_expenses_controller.g.dart";

@riverpod
class WatchRecentExpensesController extends _$WatchRecentExpensesController {
  final ExpensesRepository _expensesRepository =
      GetItWrapper.get<ExpensesRepository>();

  late final WatchRecentExpensesUseCase _watchRecentExpensesUseCase =
      WatchRecentExpensesUseCase(
    expensesRepository: _expensesRepository,
  );

  late final StreamSubscription<List<ExpenseModel>>? _expensesSubscription;

  // TODO intilize subscription here, but can also initialize outside of the build method, immediately?

  @override
  // Future<WatchRecentExpensesControllerStateData>? build() async {
  AsyncValue<WatchRecentExpensesControllerStateData?> build() {
// TODO try
    ref.onDispose(_onDispose);

    // doing this to make sure that null state comes before state by stream data
    Future.delayed(
      Duration.zero,
      _onSubscribeToStream,
    );

    return const AsyncValue.data(null);
  }

  void _onSubscribeToStream() {
    final expensesStream = _watchRecentExpensesUseCase().asBroadcastStream();

    _expensesSubscription = expensesStream.listen(
      (List<ExpenseModel> expenses) {
        state = AsyncValue<WatchRecentExpensesControllerStateData?>.data(
          WatchRecentExpensesControllerStateData(
            expenses: expenses,
          ),
        );
      },
      onError: (Object error, StackTrace stackTrace) {
        // TODO not sure if this is good here
        state = AsyncValue<WatchRecentExpensesControllerStateData?>.error(
          error,
          // making .current to match .build() rethrow state signature
          StackTrace.current,
        );
      },
    );
  }

  Future<void> _onDispose() async {
    await _expensesSubscription?.cancel();
  }
}
