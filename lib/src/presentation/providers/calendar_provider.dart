import 'package:num_calendar/src/presentation/providers/calendar_state.dart';
import 'package:num_calendar/src/utils/extensions/date_time_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_provider.g.dart';

@riverpod
class CalendarProvider extends _$CalendarProvider {
  @override
  CalendarState build() => CalendarState(
        startDate: DateTime(2022),
        endDate: DateTime(2025, 12),
      );

  void setSelectedDate(DateTime? dateTime) {
    if (dateTime != null &&
        !dateTime.isBetween(state.startDate, state.endDate)) {
      return;
    }
    state = state.copyWith(selectedDate: dateTime);
  }
}
