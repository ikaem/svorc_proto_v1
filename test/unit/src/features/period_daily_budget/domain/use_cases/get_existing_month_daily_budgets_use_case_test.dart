import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/data/entities/local/period_daily_budget/period_daily_budget_local_entity.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/models/period_daily_budget_model.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/get_existing_month_daily_budgets_use_case.dart';

void main() {
  final PeriodDailyBudgetsRepository periodDailyBudgetsRepository =
      _MockPeriodDailyBudgetsRepository();

// tested class
  final GetExistingMonthDailyBudgetsUseCase useCase =
      GetExistingMonthDailyBudgetsUseCase(
          periodDailyBudgetsRepository: periodDailyBudgetsRepository);

  setUpAll(() {
    registerFallbackValue(Period.month);
  });

  tearDown(() {
    reset(periodDailyBudgetsRepository);
  });

  group(
    GetExistingMonthDailyBudgetsUseCase,
    () {
      group(
        ".call",
        () {
          test(
            "given instance of [GetExistingMonthDailyBudgetsUseCase]"
            "when [call] is called "
            "then should call [PeriodDailyBudgetsRepository.getPeriodDailyBudgetsByPeriod] with correct arguments and return expected result",
            () async {
              // setup
              final List<PeriodDailyBudgetModel> budgets = List.generate(
                3,
                (index) => PeriodDailyBudgetModel(
                  id: index + 1,
                  period: Period.month,
                  amount: 100,
                  periodEnd: DateTime.now(),
                  periodStart: DateTime.now(),
                ),
              );

              when(
                () =>
                    periodDailyBudgetsRepository.getPeriodDailyBudgetsByPeriod(
                  period: any(named: "period"),
                ),
              ).thenAnswer(
                (_) async => budgets,
              );

              // given

              // when
              final List<PeriodDailyBudgetModel> result = await useCase();

              // then
              verify(
                () =>
                    periodDailyBudgetsRepository.getPeriodDailyBudgetsByPeriod(
                  period: Period.month,
                ),
              ).called(1);
              expect(result, equals(budgets));

              // cleanup
            },
          );
        },
      );
    },
  );
}

class _MockPeriodDailyBudgetsRepository extends Mock
    implements PeriodDailyBudgetsRepository {}
