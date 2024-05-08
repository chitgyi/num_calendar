import 'package:flutter/material.dart';
import 'package:num_calendar/src/presentation/ui/extensions/context_ext.dart';
import 'package:num_calendar/src/presentation/ui/widgets/buttons/circle_icon_button.dart';
import 'package:num_calendar/src/presentation/ui/widgets/containers/calendar_table_cell.dart';
import 'package:num_calendar/src/utils/date_utils.dart';
import 'package:num_calendar/src/utils/extensions/date_time_ext.dart';

enum CalendarSelectableType { single, multiple }

class NCalendarMonthView extends StatefulWidget {
  const NCalendarMonthView({
    super.key,
    required this.endDate,
    this.selectedDates = const {},
    required this.startDate,
    this.selectableType = CalendarSelectableType.single,
    this.onChanged,
  });
  final DateTime startDate;
  final DateTime endDate;
  final Set<DateTime> selectedDates;
  final CalendarSelectableType selectableType;
  final void Function(Set<DateTime> selectedDates)? onChanged;

  @override
  State<NCalendarMonthView> createState() => _NCalendarMonthViewState();
}

class _NCalendarMonthViewState extends State<NCalendarMonthView> {
  late DateTime inputDate; // to generate days of month
  Set<DateTime> selectedDates = {};

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    selectedDates = Set.from(widget.selectedDates);

    // make sure selected dates must be between start date and end date
    if (selectedDates.isNotEmpty) {
      selectedDates.removeWhere((selectedDate) =>
          !selectedDate.isBetween(widget.startDate, widget.endDate));
    }

    final input = switch (selectedDates.length) {
      0 when DateTime.now().isAfter(widget.endDate) => widget.endDate,
      > 0 => selectedDates.last,
      _ => DateTime.now(),
    };
    inputDate = DateTime(input.year, input.month);
  }

  bool get shouldShowNextBtn => !inputDate.equalsMonth(widget.endDate);
  bool get shouldShowPreviousBtn => !inputDate.equalsMonth(widget.startDate);

  @override
  void didUpdateWidget(covariant NCalendarMonthView oldWidget) {
    _initialize();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              inputDate.toHeaderFormat(),
              style: TextStyle(
                fontSize: 16.0,
                height: 2.5,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (shouldShowPreviousBtn)
                  CircleIconButton(
                    size: context.cellWidth * 0.8,
                    onTap: () {
                      setState(() {
                        inputDate =
                            DateTime(inputDate.year, inputDate.month - 1);
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16,
                    ),
                  )
                else
                  CalendarTableCell(
                    text: "S",
                    textStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ...['M', 'T', 'W', 'T', 'F'].map((e) => CalendarTableCell(
                      type: TableCellType.normal,
                      text: e,
                      textStyle: TextStyle(
                        color: Theme.of(context).indicatorColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    )),
                if (shouldShowNextBtn)
                  CircleIconButton(
                    size: context.cellWidth * 0.8,
                    onTap: () {
                      setState(() {
                        inputDate =
                            DateTime(inputDate.year, inputDate.month + 1);
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                  )
                else
                  CalendarTableCell(
                    text: "S",
                    textStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
              ],
            ),
            const Divider(height: 32),
            Wrap(
              children: NDateUtils.generateDaysOfMonth(inputDate)
                  .asMap()
                  .entries
                  .map(
                    (e) => CalendarTableCell(
                      onTap: () {
                        final isExist = selectedDates
                            .any((date) => date.equalsDay(e.value));

                        if (isExist) {
                          selectedDates.removeWhere(
                            (element) => element.equalsDay(e.value),
                          );
                        } else {
                          if (widget.selectableType ==
                              CalendarSelectableType.single) {
                            selectedDates.clear();
                          }
                          selectedDates.add(e.value);
                        }

                        widget.onChanged?.call(selectedDates);
                        setState(() {});
                      },
                      type: switch (e.value) {
                        _ when !inputDate.equalsMonth(e.value) =>
                          TableCellType.disabled,
                        _
                            when selectedDates
                                .any((element) => element.equalsDay(e.value)) =>
                          TableCellType.filled,
                        _ when DateTime.now().equalsDay(e.value) =>
                          TableCellType.outlined,
                        _ => TableCellType.normal,
                      },
                      text: "${e.value.day}",
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
