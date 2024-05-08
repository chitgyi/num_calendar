import 'package:flutter/material.dart';
import 'package:num_calendar/src/presentation/ui/extensions/context_ext.dart';

enum TableCellType { filled, outlined, normal, disabled }

class CalendarTableCell extends StatelessWidget {
  const CalendarTableCell({
    super.key,
    required this.text,
    this.onTap,
    this.type = TableCellType.normal,
    this.textStyle,
    this.size,
  });
  final VoidCallback? onTap;
  final String text;
  final TextStyle? textStyle;
  final TableCellType type;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final cellWidth = size ?? context.cellWidth;
    return InkWell(
      onTap: type == TableCellType.disabled ? null : onTap,
      borderRadius: BorderRadius.circular(cellWidth / 2),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: switch (type) {
            TableCellType.outlined =>
              Border.all(color: Theme.of(context).primaryColor),
            _ => null,
          },
          color: switch (type) {
            TableCellType.filled => Theme.of(context).primaryColor,
            _ => null,
          },
        ),
        width: cellWidth,
        height: cellWidth,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle ??
              TextStyle(
                color: switch (type) {
                  TableCellType.filled => Colors.white,
                  TableCellType.disabled => Colors.grey,
                  _ => Colors.black,
                },
              ),
        ),
      ),
    );
  }
}
