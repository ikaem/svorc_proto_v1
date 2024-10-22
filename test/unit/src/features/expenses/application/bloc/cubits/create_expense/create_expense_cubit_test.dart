import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/bloc/cubits/create_expense/create_expense_cubit.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/create_expense_use_case.dart';

void main() {
  final CreateExpenseUseCase mockCreateExpenseUseCase =
      _MockCreateExpenseUseCase();

  tearDown(() {
    reset(mockCreateExpenseUseCase);
  });

  group(
    CreateExpenseCubit,
    () {
      group(
        "initial state",
        () {
          test(
            "given instance of [CreateExpenseCubit]"
            "when state is retrieved"
            "then should be [CreateExpenseCubitStateInitial]",
            () async {
              // setup

              // given
              final CreateExpenseCubit createExpenseCubit = CreateExpenseCubit(
                createExpenseUseCase: mockCreateExpenseUseCase,
              );

              // when / then
              expect(
                createExpenseCubit.state,
                CreateExpenseCubitStateInitial(),
              );

              // cleanup
              addTearDown(() async {
                await createExpenseCubit.close();
              });
            },
          );
        },
      );

      group(
        ".onCreateExpense",
        () {
          test(
            "given [CreateExpenseCubitStateInitial] state"
            "when [onCreateExpense] is called and [CreateExpenseUseCase] throws"
            "then should emit expected states",
            () async {
              // setup

              // given
              final CreateExpenseCubit createExpenseCubit = CreateExpenseCubit(
                createExpenseUseCase: mockCreateExpenseUseCase,
              );

              // then
              expectLater(
                createExpenseCubit.stream,
                emitsInOrder(
                  [
                    CreateExpenseCubitStateLoading(),
                    CreateExpenseCubitStateFailure(
                      errorMessage: "There was an issue creating the expense",
                    ),
                  ],
                ),
              );

              // when
              when(() => mockCreateExpenseUseCase(
                    date: any(named: "date"),
                    amount: any(named: "amount"),
                    note: any(named: "note"),
                    categoryId: any(named: "categoryId"),
                  )).thenThrow(Exception("error"));

              await createExpenseCubit.onCreateExpense(
                date: DateTime.now(),
                amount: 100,
                note: "note",
                categoryId: 1,
              );

              await Future.delayed(Duration.zero);

              // cleanup
              addTearDown(() async {
                await createExpenseCubit.close();
              });
            },
          );

          test(
            "given [CreateExpenseCubitStateInitial] state"
            "when [onCreateExpense] is called and [CreateExpenseUseCase] returns successfully"
            "then should emit expected states",
            () async {
              // setup

              // given
              final CreateExpenseCubit createExpenseCubit = CreateExpenseCubit(
                createExpenseUseCase: mockCreateExpenseUseCase,
              );

              // then
              expectLater(
                createExpenseCubit.stream,
                emitsInOrder(
                  [
                    CreateExpenseCubitStateLoading(),
                    CreateExpenseCubitStateSuccess(
                      createdExpenseId: 1,
                    ),
                  ],
                ),
              );

              // when
              when(() => mockCreateExpenseUseCase(
                    date: any(named: "date"),
                    amount: any(named: "amount"),
                    note: any(named: "note"),
                    categoryId: any(named: "categoryId"),
                  )).thenAnswer((_) async => 1);

              await createExpenseCubit.onCreateExpense(
                date: DateTime.now(),
                amount: 100,
                note: "note",
                categoryId: 1,
              );

              await Future.delayed(Duration.zero);

              // cleanup
              addTearDown(() async {
                await createExpenseCubit.close();
              });
            },
          );
        },
      );
    },
  );
}

class _MockCreateExpenseUseCase extends Mock implements CreateExpenseUseCase {}
