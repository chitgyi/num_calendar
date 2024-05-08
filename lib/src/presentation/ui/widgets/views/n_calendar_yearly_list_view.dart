import 'package:flutter/material.dart';
import 'package:num_calendar/src/presentation/ui/widgets/containers/calendar_table_cell.dart';
import 'package:num_calendar/src/utils/date_utils.dart';
import 'package:num_calendar/src/utils/extensions/date_time_ext.dart';

class NCalendarYearlyListView extends StatelessWidget {
  const NCalendarYearlyListView({
    super.key,
    required this.endYear,
    required this.startYear,
    this.selectedDate,
    this.onTap,
  });
  final int startYear;
  final int endYear;
  final DateTime? selectedDate;
  final void Function(DateTime dateTime)? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ...List.generate(endYear - startYear + 1, (index) {
          final date = DateTime(startYear + index);
          return [
            SliverToBoxAdapter(
              child: Text(
                date.toYearFormat(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 2.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SliverGrid.builder(
              itemCount: 12,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                childAspectRatio: 8 / 9,
              ),
              itemBuilder: (BuildContext context, int index) {
                final inputDate = DateTime(date.year, index + 1);
                final isCurrentMonth =
                    selectedDate?.equalsMonth(inputDate) ?? false;
                return GestureDetector(
                  onTap: () => onTap?.call(inputDate),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isCurrentMonth
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(14),
                          ),
                        ),
                        child: Text(
                          inputDate.toMonthFormat(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isCurrentMonth ? Colors.white : Colors.grey,
                            fontSize: 16,
                            height: 2.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Wrap(
                        children: NDateUtils.generateDaysOfMonth(
                                inputDate, DateTime.monday)
                            .map(
                          (e) {
                            final isSelectedDay =
                                selectedDate?.equalsDay(e) ?? false;

                            return CalendarTableCell(
                              size: 12,
                              text: e.equalsMonth(inputDate)
                                  ? e.day.toString()
                                  : '',
                              textStyle: TextStyle(
                                fontSize: 8,
                                color: switch (e.weekday) {
                                  _ when isSelectedDay && isCurrentMonth =>
                                    Colors.white,
                                  DateTime.sunday ||
                                  DateTime.saturday =>
                                    Colors.red,
                                  _ => null,
                                },
                              ),
                              type: isSelectedDay & isCurrentMonth
                                  ? TableCellType.filled
                                  : TableCellType.normal,
                            );
                          },
                        ).toList(),
                      )
                    ],
                  ),
                );
              },
            ),
          ];
        }).reduce((value, element) => [...value, ...element]),
      ],
    );
  }
}
