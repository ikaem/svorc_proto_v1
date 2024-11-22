import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:svorc_proto_v1/src/features/expenses/application/controllers/get_recent_expenses/get_recent_expenses_controller.dart';
import 'package:svorc_proto_v1/src/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:svorc_proto_v1/src/wrappers/get_it/get_it_wrapper.dart';

void main() {
  final _MockExpensesRepository expensesRepository = _MockExpensesRepository();

  final _MockListener<AsyncValue<GetRecentExpensesControllerStateData>>
      listener =
      _MockListener<AsyncValue<GetRecentExpensesControllerStateData>>();

  setUpAll(() {
    registerFallbackValue(
        AsyncValue.data(_FakeGetRecentExpensesControllerStateData()));
  });

  setUpAll(() {
    getIt.registerSingleton<ExpensesRepository>(expensesRepository);
  });

  tearDown(() {
    reset(expensesRepository);
    reset(listener);
  });
}

class _MockExpensesRepository extends Mock implements ExpensesRepository {}

class _MockListener<T> extends Mock {
  void call(T? oldState, T newState);
}

class _FakeGetRecentExpensesControllerStateData extends Fake
    implements GetRecentExpensesControllerStateData {}
