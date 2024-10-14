import 'package:bloc_test/bloc_test.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_month_daily_budget_use_case.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/utils/helpers/period_extremes_moments_calculator.dart';
import 'package:svorc_proto_v1/src/features/reports/application/bloc/cubits/home_screen_balances_report/home_screen_balances_report_cubit.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/use_cases/get_home_screen_balances_use_case.dart';
import 'package:svorc_proto_v1/src/features/reports/domain/values/home_screen_balances_value.dart';
import 'package:svorc_proto_v1/src/features/reports/utils/helpers/month_balance_calculation_helper.dart';
// import 'package:test/test.dart';

void main() {
  final GetHomeScreenBalancesUseCase getHomeScreenBalancesUseCase =
      _MockGetHomeScreenBalancesUseCase();
  final GetMonthDailyBudgetUseCase getMonthDailyBudgetUseCase =
      _MockGetMonthDailyBudgetUseCase();

  setUpAll(() {
    registerFallbackValue(Period.month);
    registerFallbackValue(_FakePeriodDailyBudgetModel());
    registerFallbackValue(_FakePeriodExtremesMoments());
  });

  tearDown(() {
    reset(getHomeScreenBalancesUseCase);
    reset(getMonthDailyBudgetUseCase);
  });

  group(
    HomeScreenBalancesReportCubit,
    () {
      group(
        "initial state",
        () {
          test(
            "given <pre-condition to the test>"
            "when <behavior we are specifying>"
            "then should <state we expect to happen>",
            () async {
              // setup

              // given
              final HomeScreenBalancesReportCubit cubit =
                  HomeScreenBalancesReportCubit(
                getHomeScreenBalancesUseCase: getHomeScreenBalancesUseCase,
                getMonthDailyBudgetUseCase: getMonthDailyBudgetUseCase,
              );

              // when / then
              expect(
                cubit.state,
                equals(HomeScreenBalancesReportCubitStateInitial()),
              );

              // cleanup
            },
          );
        },
      );

      group(
        ".onLoadData",
        () {
          test(
            "given [HomeScreenBalancesReportCubitStateInitial] state"
            "when [onLoadData] is called and [getMonthDailyBudgetUseCase] returns null"
            "then should emit expected states",
            () async {
              // setup

              // given
              final HomeScreenBalancesReportCubit cubit =
                  HomeScreenBalancesReportCubit(
                getHomeScreenBalancesUseCase: getHomeScreenBalancesUseCase,
                getMonthDailyBudgetUseCase: getMonthDailyBudgetUseCase,
              );

              // then
              expect(
                cubit.stream,
                emitsInOrder(
                  [
                    HomeScreenBalancesReportCubitStateLoading(),
                    HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound()
                  ],
                ),
              );

              // when
              when(
                () => getMonthDailyBudgetUseCase(date: any(named: "date")),
              ).thenAnswer(
                (_) async => null,
              );
              await cubit.onLoadBalances();

              // delay needed to add the event to the stream
              await Future.delayed(Duration.zero);

              // TODO maaaybe we should test that use case was called

              // cleanup
              addTearDown(() async {
                await cubit.close();
              });
            },
          );

          test(
            "given [HomeScreenBalancesReportCubitStateInitial] state"
            "when [onLoadData] is called and [getMonthDailyBudgetUseCase] throws"
            "then should emit expected states",
            () async {
              // setup

              // given
              final HomeScreenBalancesReportCubit cubit =
                  HomeScreenBalancesReportCubit(
                getHomeScreenBalancesUseCase: getHomeScreenBalancesUseCase,
                getMonthDailyBudgetUseCase: getMonthDailyBudgetUseCase,
              );

              // then
              expect(
                cubit.stream,
                emitsInOrder(
                  [
                    HomeScreenBalancesReportCubitStateLoading(),
                    HomeScreenBalancesReportCubitStateFailure(
                      errorMessage: "There was an issue loading data",
                    )
                  ],
                ),
              );

              // when
              when(
                () => getMonthDailyBudgetUseCase(date: any(named: "date")),
              ).thenAnswer(
                (_) async => throw Exception("Some exception"),
              );
              await cubit.onLoadBalances();

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
            "when [onLoadData] is called and [GetHomeScreenBalancesUseCase] throws"
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
              when(
                () => getMonthDailyBudgetUseCase(date: any(named: "date")),
              ).thenAnswer(
                (_) async => budget,
              );

              // given
              final HomeScreenBalancesReportCubit cubit =
                  HomeScreenBalancesReportCubit(
                getHomeScreenBalancesUseCase: getHomeScreenBalancesUseCase,
                getMonthDailyBudgetUseCase: getMonthDailyBudgetUseCase,
              );

              // then
              expect(
                cubit.stream,
                emitsInOrder(
                  [
                    HomeScreenBalancesReportCubitStateLoading(),
                    HomeScreenBalancesReportCubitStateFailure(
                      errorMessage: "There was an issue loading data",
                    )
                  ],
                ),
              );

              // when
              when(
                () => getHomeScreenBalancesUseCase(
                  currentMonthDailyBudget:
                      any(named: "currentMonthDailyBudget"),
                  currentMonthExtremes: any(named: "currentMonthExtremes"),
                ),
              ).thenAnswer(
                (_) async => throw Exception("Some exception"),
              );
              await cubit.onLoadBalances();

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
            "when [onLoadData] is called and [GetHomeScreenBalancesUseCase] and [getMonthDailyBudgetUseCase] return successfully"
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
              final HomeScreenBalancesValue balances = HomeScreenBalancesValue(
                thisMonthDailyBudget: budget,
                thisWeekBalance: WeekBalanceValue(
                  accumulationValue: 50,
                  date: DateTime.now(),
                  remainderValue: 50,
                  spentValue: 50,
                ),
                thisMonthBalance: MonthBalanceValue(
                  accumulationValue: 50,
                  remainderValue: 50,
                  spentValue: 50,
                  date: DateTime.now(),
                ),
                todayBalance: DateBalanceValue(
                  accumulationValue: 50,
                  remainderValue: 50,
                  spentValue: 50,
                  date: DateTime.now(),
                ),
              );

              // given
              final HomeScreenBalancesReportCubit cubit =
                  HomeScreenBalancesReportCubit(
                getHomeScreenBalancesUseCase: getHomeScreenBalancesUseCase,
                getMonthDailyBudgetUseCase: getMonthDailyBudgetUseCase,
              );

              // then
              expect(
                cubit.stream,
                emitsInOrder(
                  [
                    HomeScreenBalancesReportCubitStateLoading(),
                    HomeScreenBalancesReportCubitStateSuccess(
                      balances: balances,
                    )
                  ],
                ),
              );

              // when
              when(
                () => getMonthDailyBudgetUseCase(date: any(named: "date")),
              ).thenAnswer(
                (_) async => budget,
              );
              when(
                () => getHomeScreenBalancesUseCase(
                  currentMonthDailyBudget:
                      any(named: "currentMonthDailyBudget"),
                  currentMonthExtremes: any(named: "currentMonthExtremes"),
                ),
              ).thenAnswer(
                (_) async => balances,
              );
              await cubit.onLoadBalances();

              // delay needed to add the event to the stream
              await Future.delayed(Duration.zero);

              // cleanup
              addTearDown(() async {
                await cubit.close();
              });
            },
          );

          // TODO keep as reference, but prefer regular test
          blocTest(
            // NOTE for some reason, three lines dont work
            // "given <pre-condition to the test>"
            "when <behavior we are specifying>"
            "then should <state we expect to happen>",
            // build: () => WeatherCubit(mockWeatherRepository),
            build: () => HomeScreenBalancesReportCubit(
              getHomeScreenBalancesUseCase: getHomeScreenBalancesUseCase,
              getMonthDailyBudgetUseCase: getMonthDailyBudgetUseCase,
            ),
            act: (HomeScreenBalancesReportCubit cubit) async {
              when(
                () => getMonthDailyBudgetUseCase(date: any(named: "date")),
              ).thenAnswer(
                (_) async => null,
              );
              await cubit.onLoadBalances();
            },
            expect: () => [
              HomeScreenBalancesReportCubitStateLoading(),
              HomeScreenBalancesReportCubitStateCurrentMonthDailyBudgetNotFound()
            ],
          );
        },
      );
    },
  );
}

class _MockGetHomeScreenBalancesUseCase extends Mock
    implements GetHomeScreenBalancesUseCase {}

class _MockGetMonthDailyBudgetUseCase extends Mock
    implements GetMonthDailyBudgetUseCase {}

class _FakePeriodDailyBudgetModel extends Fake
    implements PeriodDailyBudgetModel {}

class _FakePeriodExtremesMoments extends Fake
    implements PeriodExtremesMoments {}
