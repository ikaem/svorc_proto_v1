import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/get_recent_expenses_use_case.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

part "get_recent_expenses_controller_state_data.dart";
part "get_recent_expenses_controller.g.dart";

@riverpod
class GetRecentExpensesController extends _$GetRecentExpensesController {
  final ExpensesRepository _expensesRepository =
      GetItWrapper.get<ExpensesRepository>();

  late final GetRecentExpensesUseCase _getRecentExpensesUseCase =
      GetRecentExpensesUseCase(
    expensesRepository: _expensesRepository,
  );

  @override
  Future<GetRecentExpensesControllerStateData> build() async {
    try {
      final GetRecentExpensesControllerStateData controllerStateData =
          await _loadExpenses();

      // throw UnimplementedError();

      return controllerStateData;
    } catch (e) {
      log("Error loading recent expenses: $e");
      // rethrowing so that the error state is produced by the controller
      rethrow;
    }
  }

  Future<void> onLoadExpenses() async {
    state = const AsyncValue<GetRecentExpensesControllerStateData>.loading();

    try {
      final GetRecentExpensesControllerStateData controllerStateData =
          await _loadExpenses();
      state = AsyncValue<GetRecentExpensesControllerStateData>.data(
        controllerStateData,
      );
    } catch (e) {
      log("Error loading recent expenses: $e");
      state = AsyncValue<GetRecentExpensesControllerStateData>.error(
        e,
        // making .current to match .build() rethrow state signature
        StackTrace.current,
      );
    }
  }

  Future<GetRecentExpensesControllerStateData> _loadExpenses() async {
    final List<ExpenseModel> expenses = await _getRecentExpensesUseCase();

    return GetRecentExpensesControllerStateData(
      expenses: expenses,
    );
  }
}
