import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  bool equalsMonth(DateTime dateTime) =>
      dateTime.year == year && dateTime.month == month;

  bool equalsDay(DateTime dateTime) =>
      dateTime.year == year && dateTime.month == month && dateTime.day == day;

  bool isBetween(DateTime start, DateTime end) {
    return isBefore(end.add(const Duration(minutes: 1))) &&
        isAfter(
          start.add(
            const Duration(minutes: -1),
          ),
        );
  }

  String toHeaderFormat() => DateFormat("MMMM yyyy").format(this);

  String toMonthFormat() => DateFormat("MMMM").format(this);
  String toYearFormat() => DateFormat("yyyy").format(this);
  String toDefaultFormat() {
    final dayMap = {1: r'st', 2: r'nd', 3: r'rd'};
    final dayInTimes = dayMap[day] ?? 'th';
    return DateFormat("EEEE d'$dayInTimes' MMMM yyyy").format(this);
  }
}
