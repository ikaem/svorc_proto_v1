class DateBalanceGeneratorHelper {
  DateBalanceGeneratorHelper({
    required this.date,
    required this.spentValue,
  });

  final DateTime date;
  final int spentValue;

  int getRemainderValue(int dailyBudgetAmount) {
    return dailyBudgetAmount - spentValue;
  }

  int getAccumulationValue(
    int dailyBudgetAmount,
    int prevDayAccumulationValue,
  ) {
    final todayRemainderValue = getRemainderValue(dailyBudgetAmount);
    final todayAccumulationValue =
        todayRemainderValue + prevDayAccumulationValue;

    return todayAccumulationValue;
  }
}
