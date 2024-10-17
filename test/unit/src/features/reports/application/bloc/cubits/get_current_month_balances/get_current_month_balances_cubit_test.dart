import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';

import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/get_current_month_balances/get_current_month_balances_cubit.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_month_balances_use_case.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/values/month_balances_value.dart';
import 'package:svorc_proto_v1/src/features/reports/utils/helpers/month_balance_calculation_helper.dart';

void main() {
  final GetMonthBalancesUseCase getHomeScreenBalancesUseCase =
      _MockGetHomeScreenBalancesUseCase();

  setUpAll(() {
    registerFallbackValue(_FakePeriodDailyBudgetModel());
    registerFallbackValue(_FakePeriodExtremesMoments());
  });

  tearDown(() {
    reset(getHomeScreenBalancesUseCase);
  });

  group(
    GetCurrentMonthBalancesCubit,
    () {
      group(
        "initial state",
        () {
          test(
            "given instance of [HomeScreenBalancesReportCubit]"
            "when state is retrieved"
            "then should be [HomeScreenBalancesReportCubitStateInitial]",
            () async {
              // setup

              // given
              final GetCurrentMonthBalancesCubit cubit =
                  GetCurrentMonthBalancesCubit(
                getHomeScreenBalancesUseCase: getHomeScreenBalancesUseCase,
              );

              // when / then
              expect(
                cubit.state,
                equals(GetCurrentMonthBalancesCubitStateInitial()),
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
        ".onLoadBalances",
        () {
          test(
            "given [HomeScreenBalancesReportCubitStateInitial] state"
            "when [onLoadBalances] is called and [GetHomeScreenBalancesUseCase] throws"
            "then should emit expected states",
            () async {
              // setup
              final PeriodDailyBudgetModel budget = PeriodDailyBudgetModel(
                id: 1,
                periodStart: DateTime.now(),
                periodEnd: DateTime.now(),
                amount: 100,
                period: Period.month,
              );

              // given
              final GetCurrentMonthBalancesCubit cubit =
                  GetCurrentMonthBalancesCubit(
                getHomeScreenBalancesUseCase: getHomeScreenBalancesUseCase,
              );

              // then
              expect(
                cubit.stream,
                emitsInOrder(
                  [
                    GetCurrentMonthBalancesCubitStateLoading(),
                    GetCurrentMonthBalancesCubitStateFailure(
                      errorMessage: "There was an issue loading data",
                    )
                  ],
                ),
              );

              // when
              when(
                () => getHomeScreenBalancesUseCase(
                  monthDailyBudget: any(named: "currentMonthDailyBudget"),
                  monthExtremes: any(named: "currentMonthExtremes"),
                ),
              ).thenAnswer(
                (_) async => throw Exception("Some exception"),
              );
              await cubit.onLoadBalances(currentMonthDailyBudget: budget);

              // delay needed to add the event to the stream
              await Future.delayed(Duration.zero);

              // cleanup
              addTearDown(() async {
                await cubit.close();
              });
            },
          );

          test(
            "given [HomeScreenBalancesReportCubitStateInitial] state"
            "when [onLoadBalances] is called and [GetHomeScreenBalancesUseCase] and [GetMonthDailyBudgetUseCase] return successfully"
            "then should emit expected states",
            () async {
              // setup
              final PeriodDailyBudgetModel budget = PeriodDailyBudgetModel(
                id: 1,
                periodStart: DateTime.now(),
                periodEnd: DateTime.now(),
                amount: 100,
                period: Period.month,
              );
              final MonthBalancesValue balances = MonthBalancesValue(
                currentMonthDailyBudget: budget,
                currentWeekBalance: WeekBalanceValue(
                  accumulationValue: 50,
                  date: DateTime.now(),
                  remainderValue: 50,
                  spentValue: 50,
                ),
                currentMonthBalance: MonthBalanceValue(
                  accumulationValue: 50,
                  remainderValue: 50,
                  spentValue: 50,
                  date: DateTime.now(),
                ),
                currentDayBalance: DateBalanceValue(
                  accumulationValue: 50,
                  remainderValue: 50,
                  spentValue: 50,
                  date: DateTime.now(),
                ),
              );

              // given
              final GetCurrentMonthBalancesCubit cubit =
                  GetCurrentMonthBalancesCubit(
                getHomeScreenBalancesUseCase: getHomeScreenBalancesUseCase,
              );

              // then
              expect(
                cubit.stream,
                emitsInOrder(
                  [
                    GetCurrentMonthBalancesCubitStateLoading(),
                    GetCurrentMonthBalancesCubitStateSuccess(
                      balances: balances,
                    )
                  ],
                ),
              );

              when(
                () => getHomeScreenBalancesUseCase(
                  monthDailyBudget: any(named: "currentMonthDailyBudget"),
                  monthExtremes: any(named: "currentMonthExtremes"),
                ),
              ).thenAnswer(
                (_) async => balances,
              );
              await cubit.onLoadBalances(
                currentMonthDailyBudget: budget,
              );

              // delay needed to add the event to the stream
              await Future.delayed(Duration.zero);

              // cleanup
              addTearDown(() async {
                await cubit.close();
              });
            },
          );

          // TODO keep as reference, but prefer regular test
          // blocTest(
          //   // NOTE for some reason, three lines dont work
          //   // "given <pre-condition to the test>"
          //   "when <behavior we are specifying>"
          //   "then should <state we expect to happen>",
          //   // build: () => WeatherCubit(mockWeatherRepository),
          //   build: () => HomeScreenBalancesReportCubit(
          //     getHomeScreenBalancesUseCase: getHomeScreenBalancesUseCase,
          //     // getMonthDailyBudgetUseCase: getMonthDailyBudgetUseCase,
          //   ),
          //   act: (HomeScreenBalancesReportCubit cubit) async {
          //     when(
          //       () => getMonthDailyBudgetUseCase(date: any(named: "date")),
          //     ).thenAnswer(
          //       (_) async => null,
          //     );
          //     await cubit.onLoadBalances();
          //   },
          //   expect: () => [
          //     HomeScreenBalancesReportCubitStateLoading(),
          //     HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound()
          //   ],
          // );
        },
      );
    },
  );
}

class _MockGetHomeScreenBalancesUseCase extends Mock
    implements GetMonthBalancesUseCase {}

class _FakePeriodDailyBudgetModel extends Fake
    implements PeriodDailyBudgetModel {}

class _FakePeriodExtremesMoments extends Fake
    implements PeriodExtremesMoments {}
