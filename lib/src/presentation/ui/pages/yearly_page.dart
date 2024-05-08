import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:num_calendar/src/presentation/providers/calendar_provider.dart';
import 'package:num_calendar/src/presentation/ui/widgets/containers/custom_scaffold.dart';
import 'package:num_calendar/src/presentation/ui/widgets/views/n_calendar_yearly_list_view.dart';

class YearlyPage extends ConsumerWidget {
  const YearlyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarProviderProvider);
    final provider = ref.read(calendarProviderProvider.notifier);

    return CustomScaffold(
      title: 'Calendar',
      body: NCalendarYearlyListView(
        startYear: calendarState.startDate.year,
        endYear: calendarState.endDate.year,
        selectedDate: calendarState.selectedDate,
        onTap: (dateTime) => provider.setSelectedDate(dateTime),
      ),
    );
  }
}
