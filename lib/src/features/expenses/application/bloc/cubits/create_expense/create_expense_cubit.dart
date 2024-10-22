import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/create_expense_use_case.dart';

part "create_expense_cubit_state.dart";

class CreateExpenseCubit extends Cubit<CreateExpenseCubitState> {
  CreateExpenseCubit({
    required CreateExpenseUseCase createExpenseUseCase,
  })  : _createExpenseUseCase = createExpenseUseCase,
        super(CreateExpenseCubitStateInitial());

  final CreateExpenseUseCase _createExpenseUseCase;

  Future<void> onCreateExpense({
    required DateTime date,
    required int amount,
    required String? note,
    required int categoryId,
  }) async {
    emit(CreateExpenseCubitStateLoading());

    try {
      final int id = await _createExpenseUseCase(
        date: date,
        amount: amount,
        note: note,
        categoryId: categoryId,
      );

      emit(CreateExpenseCubitStateSuccess(
        createdExpenseId: id,
      ));
    } catch (e) {
      log(e.toString());
      emit(
        CreateExpenseCubitStateFailure(
          errorMessage: "There was an issue creating the expense",
        ),
      );
    }
  }
}
