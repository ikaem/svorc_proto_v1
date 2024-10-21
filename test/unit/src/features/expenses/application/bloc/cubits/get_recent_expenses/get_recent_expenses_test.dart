import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/categories/domain/models/category_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/bloc/cubits/get_recent_expenses/get_recent_expenses_cubit.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/models/expense_model.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/get_recent_expenses_use_case.dart';

void main() {
  final GetRecentExpensesUseCase getRecentExpensesUseCase =
      _MockGetRecentExpensesUseCase();

  tearDown(() {
    reset(getRecentExpensesUseCase);
  });

  group(
    GetRecentExpensesCubit,
    () {
      group(
        "initial state",
        () {
          test(
            "given instance of [GetRecentExpensesCubit]"
            "when state is retrieved"
            "then should be [GetRecentExpensesCubitStateInitial]",
            () async {
              // setup

              // given
              final GetRecentExpensesCubit cubit = GetRecentExpensesCubit(
                getRecentExpensesUseCase: getRecentExpensesUseCase,
              );

              // when / then
              expect(
                cubit.state,
                equals(GetRecentExpensesCubitStateInitial()),
              );

              // cleanup
              addTearDown(() async {
                await cubit.close();
              });
            },
          );
        },
      );

      group(
        ".onLoadRecentExpenses",
        () {
          test(
            "given [GetRecentExpensesCubitStateInitial] state"
            "when [onLoadRecentExpenses] is called and [GetRecentExpensesUseCase] throws"
            "then should emit expected states",
            () async {
              // setup

              // given
              final GetRecentExpensesCubit cubit = GetRecentExpensesCubit(
                getRecentExpensesUseCase: getRecentExpensesUseCase,
              );

              // then
              expectLater(
                cubit.stream,
                emitsInOrder(
                  [
                    GetRecentExpensesCubitStateLoading(),
                    GetRecentExpensesCubitStateFailure(
                      errorMessage: "There was an issue loading data",
                    ),
                  ],
                ),
              );

              // when
              when(() => getRecentExpensesUseCase()).thenThrow(
                Exception("error"),
              );
              await cubit.onLoadRecentExpenses();

              await Future.delayed(Duration.zero);

              // cleanup
              addTearDown(() async {
                await cubit.close();
              });
            },
          );

          test(
            "given [GetRecentExpensesCubitStateInitial] state"
            "when [onLoadRecentExpenses] is called and [GetRecentExpensesUseCase] returns expenses"
            "then should emit expected states",
            () async {
              // setup
              final List<ExpenseModel> expenses = List.generate(
                5,
                (index) => ExpenseModel(
                  id: index,
                  amount: 100,
                  date: DateTime.now(),
                  category: CategoryModel(
                    id: index,
                    name: "Category $index",
                  ),
                ),
              );

              // given
              final GetRecentExpensesCubit cubit = GetRecentExpensesCubit(
                getRecentExpensesUseCase: getRecentExpensesUseCase,
              );

              // then
              expectLater(
                cubit.stream,
                emitsInOrder(
                  [
                    GetRecentExpensesCubitStateLoading(),
                    GetRecentExpensesCubitStateSuccess(
                      expenses: expenses,
                    ),
                  ],
                ),
              );

              // when
              when(() => getRecentExpensesUseCase()).thenAnswer(
                (_) async => expenses,
              );

              await cubit.onLoadRecentExpenses();

              await Future.delayed(Duration.zero);

              // cleanup
              addTearDown(() async {
                await cubit.close();
              });
            },
          );
        },
      );
    },
  );
}

class _MockGetRecentExpensesUseCase extends Mock
    implements GetRecentExpensesUseCase {}
