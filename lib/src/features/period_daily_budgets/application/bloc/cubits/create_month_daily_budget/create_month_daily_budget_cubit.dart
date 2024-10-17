import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/create_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

part "create_month_daily_budget_cubit_state.dart";

class CreateMonthDailyBudgetCubit
    extends Cubit<CreateMonthDailyBudgetCubitState> {
  CreateMonthDailyBudgetCubit({
    required CreateMonthDailyBudgetUseCase createMonthDailyBudgetUseCase,
  })  : _createMonthDailyBudgetUseCase = createMonthDailyBudgetUseCase,
        super(CreateMonthDailyBudgetCubitStateInitial());

  final CreateMonthDailyBudgetUseCase _createMonthDailyBudgetUseCase;

  Future<void> onCreateBudget({
    required DateTime date,
    required int amount,
  }) async {
    emit(CreateMonthDailyBudgetCubitStateLoading());

    try {
      final PeriodExtremesMoments monthExtremes =
          PeriodExtremesMomentsCalculator.calculateMonthMoments(
        monthIndex: date.month,
        year: date.year,
      );

      final int id = await _createMonthDailyBudgetUseCase(
        monthExtremes: monthExtremes,
        amount: amount,
      );

      emit(CreateMonthDailyBudgetCubitStateSuccess(
        createdDailyBudgetId: id,
      ));
    } catch (e) {
      log(e.toString());
      emit(
        CreateMonthDailyBudgetCubitStateFailure(
          errorMessage: "There was an issue creating the budget",
        ),
      );
    }
  }
}
