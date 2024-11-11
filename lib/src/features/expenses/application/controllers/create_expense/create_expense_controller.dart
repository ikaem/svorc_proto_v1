import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/create_expense_use_case.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

part "create_expense_controller_state.dart";
part "create_expense_controller.g.dart";

@riverpod
class CreateExpenseController extends _$CreateExpenseController {
  final ExpensesRepository expensesRepository =
      GetItWrapper.get<ExpensesRepository>();

  late final CreateExpenseUseCase createExpenseUseCase =
      CreateExpenseUseCase(expensesRepository: expensesRepository);

  AsyncValue<CreateExpenseControllerState> build() {
    return const AsyncValue<CreateExpenseControllerState>.data(
      CreateExpenseControllerState(createdExpenseId: null),
    );
  }

  Future<void> onCreateExpense({
    required DateTime date,
    required int amount,
    required String? note,
    required int categoryId,
  }) async {
    state = const AsyncValue<CreateExpenseControllerState>.loading();

    try {
      final int id = await createExpenseUseCase(
        date: date,
        amount: amount,
        note: note,
        categoryId: categoryId,
      );

      state = AsyncValue<CreateExpenseControllerState>.data(
        CreateExpenseControllerState(createdExpenseId: id),
      );
    } catch (e) {
      state = AsyncValue<CreateExpenseControllerState>.error(
        e,
        // making .current to match .build() rethrow state signature
        StackTrace.current,
      );
    }
  }
}
