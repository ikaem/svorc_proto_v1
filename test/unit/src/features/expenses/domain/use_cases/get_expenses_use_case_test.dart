import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/use_cases/get_expenses_use_case.dart';

void main() {
  final ExpensesRepository expensesRepository = _MockExpensesRepository();

  // tested class
  final GetExpensesUseCase useCase =
      GetExpensesUseCase(expensesRepository: expensesRepository);

  tearDown(() {
    reset(expensesRepository);
  });

  group(
    GetExpensesUseCase,
    () {},
  );
}

class _MockExpensesRepository extends Mock implements ExpensesRepository {}
