import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/repositories/period_daily_budgets_repository.dart';
import 'package:svorc_proto_v1/src/features/period_daily_budgets/domain/use_cases/update_month_daily_budget_use_case.dart';

void main() {
  final _MockPeriodDailyBudgetsRepository mockPeriodDailyBudgetsRepository =
      _MockPeriodDailyBudgetsRepository();

  // tested class
  final UpdateMonthDailyBudgetUseCase useCase = UpdateMonthDailyBudgetUseCase(
    mockPeriodDailyBudgetsRepository,
  );

  tearDown(() {
    reset(mockPeriodDailyBudgetsRepository);
  });

  group(
    UpdateMonthDailyBudgetUseCase,
    () {
      group(
        ".call()",
        () {
          test(
            "given [amount] and [id]"
            "when [call] is called"
            "then should call [PeriodDailyBudgetsRepository.updatePeriodDailyBudget] with correct arguments and return expected result",
            () async {
              // setup
              when(
                () => mockPeriodDailyBudgetsRepository.updatePeriodDailyBudget(
                  amount: any(named: "amount"),
                  id: any(named: "id"),
                ),
              ).thenAnswer(
                (_) async => 1,
              );

              // given
              const int amount = 100;
              const int id = 1;

              // when
              final int result = await useCase(
                amount: amount,
                id: id,
              );

              // then
              verify(
                () => mockPeriodDailyBudgetsRepository.updatePeriodDailyBudget(
                  amount: amount,
                  id: id,
                ),
              ).called(1);
              expect(result, equals(1));

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
