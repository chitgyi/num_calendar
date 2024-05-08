import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_state.freezed.dart';

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState({
    required DateTime startDate,
    required DateTime endDate,
    DateTime? selectedDate,
  }) = _CalendarState;
}
