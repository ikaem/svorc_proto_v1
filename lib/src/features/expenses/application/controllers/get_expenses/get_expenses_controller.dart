import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/get_expenses_use_case.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/values/get_expenses_filter_value.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

part "get_expenses_controller_state_data.dart";
part "get_expenses_controller.g.dart";

@riverpod
class GetExpensesController extends _$GetExpensesController {
  final ExpensesRepository _expensesRepository =
      GetItWrapper.get<ExpensesRepository>();

  late final GetExpensesUseCase _getExpensesUseCase = GetExpensesUseCase(
    expensesRepository: _expensesRepository,
  );

  // allowed to be changed
  DateTime? _minDate;
  DateTime? _maxDate;

  // not allowed to be changed
  final int _limit = 20;
  int _offset = 0;

  @override
  AsyncValue<GetExpensesControllerStateData?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> onGetExpenses({
    required DateTime? minDate,
    required DateTime? maxDate,
  }) async {
    // NOTE: this has to be done before set state to loading
    // TODO this could be extracted into a function
    final int currentExpensesCount = state.value?.expenses.length ?? 0;

    // offset is now 0 + 20 = 20 - so we need + 1 to start from 21
    final newOffset = _offset + currentExpensesCount;
    _offset = newOffset;

    final oldExpenses = state.value?.expenses ?? [];
    //

    // apparently, loading state still holds old state values? i wonder if we can access it in the widget, to actually show old data? - not really - at least i dont see it
    state = const AsyncValue<GetExpensesControllerStateData>.loading();
    // final expensesAfterLoading = state.value?.expenses; -> this is null

    try {
      final filter = GetExpensesFilterValue(
        minDate: minDate,
        maxDate: maxDate,
        limit: _limit,
        offset: _offset,
      );

      final List<ExpenseModel> expenses = await _getExpensesUseCase(filter);

      final updatedExpenses = [
        ...oldExpenses,
        ...expenses,
      ];

      state = AsyncValue<GetExpensesControllerStateData>.data(
        GetExpensesControllerStateData(
          expenses: updatedExpenses,
        ),
      );
    } catch (e) {
      log("Error loading expenses: $e");
      state = AsyncValue<GetExpensesControllerStateData>.error(
        e,
        StackTrace.current,
      );
    }

    // TODO postponing this for later --------------------------------
    // _handleFiltersChange(
    //   minDate: minDate,
    //   maxDate: maxDate,
    // );

    // // set filters - i guess they can be changed
    // // TODO maybe this can be done in its own function, or in the above one
    // _minDate = minDate;
    // _maxDate = maxDate;

    // we will have to
    // - reset offset to 0 if allowed filters change
  }

  void _handleFiltersChange({
    required DateTime? minDate,
    required DateTime? maxDate,
  }) {
    final bool shouldResetOffset = _minDate != minDate || _maxDate != maxDate;

    if (shouldResetOffset) {
      _offset = 0;
      // should probably also reset state itself - but that would rerender the whole widget? - thats why for now we dont do that
    }
  }
}

/* 

ok, what do we have

- we have a controller which does not fetch immediatelly
-- instead, it has a function to onGetExpenses
-- it accepts
--- min date
--- max date
--- limit 
--- offset


- ok, so lets say it does not accept any of that. we just have empty
-- we always fetch all expenses - but start from 20 last ones
-- we always fetch 20 expenses
-- we define offset as 20 + 1 

this way for now we dont bother with filters outside the controller 

- we only have function to fetchExpenses


------------
now second step
- controller controls limit and offset
- onGetExpenses allows to pass
-- min date
-- max date

- now, the controller has to know what are current filters 
-- why? because we have to know to reset offset to 0 if filters change
-- so how to know what are current filters?
--- we have to store them in the controller
--- so we have in the controller 
---- _minDate (initial is null)
---- _maxDate (initial is null)
---- _limit (initial is 20) - not allowed to be changed
---- _offset (initial is 0) - not allowed to be changed


 */
