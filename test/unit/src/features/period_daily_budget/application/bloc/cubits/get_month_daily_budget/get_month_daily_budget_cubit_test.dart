import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/application/bloc/cubits/get_month_daily_budget/get_month_daily_budget_cubit.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_month_daily_budget_use_case.dart';

void main() {
  final GetMonthDailyBudgetUseCase getMonthDailyBudgetUseCase =
      _MockGetMonthDailyBudgetUseCase();

  tearDown(() {
    reset(getMonthDailyBudgetUseCase);
  });

  group(
    GetMonthDailyBudgetCubit,
    () {
      group(
        "initial state",
        () {
          test(
            "given instance of [GetMonthDailyBudgetCubit]"
            "when state is retrieved"
            "then should be [HomeScreenBalancesReportCubitStateInitial]",
            () async {
              // setup

              // given
              final GetMonthDailyBudgetCubit cubit = GetMonthDailyBudgetCubit(
                getMonthDailyBudgetUseCase: getMonthDailyBudgetUseCase,
              );

              // when / then
              expect(
                cubit.state,
                equals(GetMonthDailyBudgetCubitStateInitial()),
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
        ".onLoadBudget",
        () {
          test(
            "given [GetMonthDailyBudgetCubitStateInitial] state"
            "when [onLoadBudget] is called and [GetMonthDailyBudgetUseCase] returns null"
            "then should emit expected states",
            () async {
              // setup

              // given
              final GetMonthDailyBudgetCubit cubit = GetMonthDailyBudgetCubit(
                getMonthDailyBudgetUseCase: getMonthDailyBudgetUseCase,
              );

              // then
              expectLater(
                cubit.stream,
                emitsInOrder(
                  [
                    GetMonthDailyBudgetCubitStateLoading(),
                    GetMonthDailyBudgetCubitStateMonthDailyBudgetNotFound(),
                  ],
                ),
              );

              // when
              when(() => getMonthDailyBudgetUseCase(date: any(named: "date")))
                  .thenAnswer(
                (_) async => null,
              );
              await cubit.onLoadBudget(date: DateTime.now());

              await Future.delayed(Duration.zero);

              // cleanup
              addTearDown(() async {
                await cubit.close();
              });
            },
          );

          test(
            "given [GetMonthDailyBudgetCubitStateInitial] state"
            "when [onLoadBudget] is called and [GetMonthDailyBudgetUseCase] throws"
            "then should emit expected states",
            () async {
              // setup

              // given
              final GetMonthDailyBudgetCubit cubit = GetMonthDailyBudgetCubit(
                getMonthDailyBudgetUseCase: getMonthDailyBudgetUseCase,
              );

              // then
              expectLater(
                cubit.stream,
                emitsInOrder(
                  [
                    GetMonthDailyBudgetCubitStateLoading(),
                    GetMonthDailyBudgetCubitStateFailure(
                      errorMessage: "There was an issue loading data",
                    ),
                  ],
                ),
              );

              // when
              when(() => getMonthDailyBudgetUseCase(date: any(named: "date")))
                  .thenThrow(Exception("error"));
              await cubit.onLoadBudget(date: DateTime.now());

              await Future.delayed(Duration.zero);

              // cleanup
              addTearDown(() async {
                await cubit.close();
              });
            },
          );

          test(
            "given [GetMonthDailyBudgetCubitStateInitial] state"
            "when [onLoadBudget] is called and [GetMonthDailyBudgetUseCase] returns daily budget"
            "then should emit expected states",
            () async {
              // setup
              final PeriodDailyBudgetModel dailyBudget = PeriodDailyBudgetModel(
                amount: 100,
                id: 1,
                periodEnd: DateTime.now(),
                periodStart: DateTime.now(),
                period: Period.month,
              );

              // given
              final GetMonthDailyBudgetCubit cubit = GetMonthDailyBudgetCubit(
                getMonthDailyBudgetUseCase: getMonthDailyBudgetUseCase,
              );

              // then
              expectLater(
                cubit.stream,
                emitsInOrder(
                  [
                    GetMonthDailyBudgetCubitStateLoading(),
                    GetMonthDailyBudgetCubitStateSuccess(
                      dailyBudget: dailyBudget,
                    ),
                  ],
                ),
              );

              // when
              when(() => getMonthDailyBudgetUseCase(date: any(named: "date")))
                  .thenAnswer((_) async => dailyBudget);
              await cubit.onLoadBudget(date: DateTime.now());

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

class _MockGetMonthDailyBudgetUseCase extends Mock
    implements GetMonthDailyBudgetUseCase {}
