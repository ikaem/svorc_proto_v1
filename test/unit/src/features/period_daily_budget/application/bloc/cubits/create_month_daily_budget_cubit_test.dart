import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/bloc/cubits/create_month_daily_budget_cubit.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/create_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';

void main() {
  final CreateMonthDailyBudgetUseCase mockCreateMonthDailyBudgetUseCase =
      _MockCreateMonthDailyBudgetUseCase();

  setUpAll(() {
    registerFallbackValue(_FakePeriodExtremesMoments());
  });

  tearDown(() {
    reset(mockCreateMonthDailyBudgetUseCase);
  });

  group(
    CreateMonthDailyBudgetCubit,
    () {
      group(
        "initial state",
        () {
          test(
            "given instance of [CreateMonthDailyBudgetCubit]"
            "when state is retrieved"
            "then should be [CreateMonthDailyBudgetCubitStateInitial]",
            () async {
              // setup

              // given
              final CreateMonthDailyBudgetCubit createMonthDailyBudgetCubit =
                  CreateMonthDailyBudgetCubit(
                createMonthDailyBudgetUseCase:
                    mockCreateMonthDailyBudgetUseCase,
              );

              // when / then
              expect(
                createMonthDailyBudgetCubit.state,
                CreateMonthDailyBudgetCubitStateInitial(),
              );

              // cleanup
              addTearDown(() async {
                await createMonthDailyBudgetCubit.close();
              });
            },
          );
        },
      );

      group(
        ".onCreateBudget",
        () {
          test(
            "given [CreateMonthDailyBudgetCubitStateInitial] state"
            "when [onCreateBudget] is called and [CreateMonthDailyBudgetUseCase] throws"
            "then should emit expected states",
            () async {
              // setup

              // given
              final CreateMonthDailyBudgetCubit createMonthDailyBudgetCubit =
                  CreateMonthDailyBudgetCubit(
                createMonthDailyBudgetUseCase:
                    mockCreateMonthDailyBudgetUseCase,
              );

              // then
              expect(
                createMonthDailyBudgetCubit.stream,
                emitsInOrder(
                  [
                    CreateMonthDailyBudgetCubitStateLoading(),
                    CreateMonthDailyBudgetCubitStateFailure(
                      errorMessage: "There was an issue creating the budget",
                    ),
                  ],
                ),
              );

              // when
              when(() => mockCreateMonthDailyBudgetUseCase(
                    monthExtremes: any(named: "monthExtremes"),
                    amount: any(named: "amount"),
                  )).thenThrow(Exception("error"));
              await createMonthDailyBudgetCubit.onCreateBudget(
                date: DateTime.now(),
                amount: 100,
              );

              await Future.delayed(Duration.zero);

              // cleanup
              addTearDown(() async {
                await createMonthDailyBudgetCubit.close();
              });
            },
          );

          test(
            "given [CreateMonthDailyBudgetCubitStateInitial] state"
            "when [onCreateBudget] is called and [CreateMonthDailyBudgetUseCase] returns successfully"
            "then should emit expected states",
            () async {
              // setup

              // given
              final CreateMonthDailyBudgetCubit createMonthDailyBudgetCubit =
                  CreateMonthDailyBudgetCubit(
                createMonthDailyBudgetUseCase:
                    mockCreateMonthDailyBudgetUseCase,
              );

              // then
              expect(
                createMonthDailyBudgetCubit.stream,
                emitsInOrder(
                  [
                    CreateMonthDailyBudgetCubitStateLoading(),
                    CreateMonthDailyBudgetCubitStateSuccess(
                      createdDailyBudgetId: 1,
                    ),
                  ],
                ),
              );

              // when
              when(() => mockCreateMonthDailyBudgetUseCase(
                    monthExtremes: any(named: "monthExtremes"),
                    amount: any(named: "amount"),
                  )).thenAnswer((_) async => 1);

              await createMonthDailyBudgetCubit.onCreateBudget(
                date: DateTime.now(),
                amount: 100,
              );

              // cleanup
              addTearDown(() async {
                await createMonthDailyBudgetCubit.close();
              });
            },
          );
        },
      );
    },
  );
}

class _MockCreateMonthDailyBudgetUseCase extends Mock
    implements CreateMonthDailyBudgetUseCase {}

class _FakePeriodExtremesMoments extends Fake
    implements PeriodExtremesMoments {}
