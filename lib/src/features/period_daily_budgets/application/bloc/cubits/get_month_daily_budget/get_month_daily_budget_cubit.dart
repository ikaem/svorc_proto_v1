import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_month_daily_budget_use_case.dart';

part "get_month_daily_budget_cubit_state.dart";

class GetMonthDailyBudgetCubit extends Cubit<GetMonthDailyBudgetCubitState> {
  GetMonthDailyBudgetCubit({
    required GetMonthDailyBudgetUseCase getMonthDailyBudgetUseCase,
  })  : _getMonthDailyBudgetUseCase = getMonthDailyBudgetUseCase,
        super(GetMonthDailyBudgetCubitStateInitial());

  final GetMonthDailyBudgetUseCase _getMonthDailyBudgetUseCase;

  Future<void> onLoadBudget({
    required DateTime date,
  }) async {
    emit(GetMonthDailyBudgetCubitStateLoading());

    try {
      final PeriodDailyBudgetModel? monthDailyBudget =
          await _getMonthDailyBudgetUseCase(
        date: date,
      );

      if (monthDailyBudget == null) {
        // TODO maybe should throw some more meaningfull exception  custom one
        // throw Exception("Month daily budget not found");
        emit(GetMonthDailyBudgetCubitStateMonthDailyBudgetNotFound());
        return;
      }

      emit(GetMonthDailyBudgetCubitStateSuccess(
        dailyBudget: monthDailyBudget,
      ));
    } catch (e) {
      log(e.toString());
      emit(
        GetMonthDailyBudgetCubitStateFailure(
          errorMessage: "There was an issue loading data",
        ),
      );
    }
  }
}
