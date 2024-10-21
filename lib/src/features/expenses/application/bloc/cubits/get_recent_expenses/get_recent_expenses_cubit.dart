import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/get_recent_expenses_use_case.dart';

part "get_recent_expenses_cubit_state.dart";

class GetRecentExpensesCubit extends Cubit<GetRecentExpensesCubitState> {
  GetRecentExpensesCubit({
    required this.getRecentExpensesUseCase,
  }) : super(GetRecentExpensesCubitStateInitial());

  final GetRecentExpensesUseCase getRecentExpensesUseCase;

  Future<void> onLoadRecentExpenses() async {
    emit(GetRecentExpensesCubitStateLoading());

    try {
      final List<ExpenseModel> expenses = await getRecentExpensesUseCase();
      emit(GetRecentExpensesCubitStateSuccess(
        expenses: expenses,
      ));
    } catch (e) {
      log(e.toString());
      emit(
        GetRecentExpensesCubitStateFailure(
          errorMessage: "There was an issue loading data",
        ),
      );
    }
  }
}
