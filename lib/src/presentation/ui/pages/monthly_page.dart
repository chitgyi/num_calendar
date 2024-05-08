import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:num_calendar/src/presentation/providers/calendar_provider.dart';
import 'package:num_calendar/src/presentation/ui/widgets/containers/custom_scaffold.dart';
import 'package:num_calendar/src/presentation/ui/widgets/views/n_calendar_monthly_view.dart';
import 'package:num_calendar/src/utils/extensions/date_time_ext.dart';

class MonthlyPage extends ConsumerWidget {
  const MonthlyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarProviderProvider);
    final provider = ref.read(calendarProviderProvider.notifier);

    return CustomScaffold(
      title: 'Calendar',
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          NCalendarMonthView(
            startDate: calendarState.startDate,
            endDate: calendarState.endDate,
            // change business logic if you want to have multiple selectable
            selectableType: CalendarSelectableType.single,
            selectedDates: switch (calendarState.selectedDate) {
              DateTime() => {calendarState.selectedDate!},
              _ => {},
            },
            onChanged: (selectedDates) {
              final selectedDate = switch (selectedDates.isNotEmpty) {
                true => selectedDates.first,
                _ => null,
              };
              provider.setSelectedDate(selectedDate);
            },
          ),
          const SizedBox(height: 24.0),
          if (calendarState.selectedDate != null)
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              child: Text(
                calendarState.selectedDate!.toDefaultFormat(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
        ],
      ),
    );
  }
}
