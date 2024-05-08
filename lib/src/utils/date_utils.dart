final class NDateUtils {
  static List<DateTime> generateDaysOfMonth(DateTime input,
      [int rotation = DateTime.sunday]) {
    final inputDate = DateTime(input.year, input.month + 01, 00);
    final startDate = DateTime(inputDate.year, inputDate.month, 01);

    final dates = <DateTime>[];

    // rotation day will start first
    final prefixCount = (startDate.weekday - rotation) % 7;
    final prefixDates = List.generate(
      prefixCount,
      (index) => startDate.subtract(Duration(days: index + 1)),
    );
    dates.addAll(prefixDates.reversed);

    List.generate(
      35 - dates.length,
      (index) => dates.add(startDate.add(
        Duration(days: index),
      )),
    );
    return dates;
  }
}
