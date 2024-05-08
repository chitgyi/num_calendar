import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:num_calendar/num_calendar_app.dart';

void main() => runApp(
      const ProviderScope(
        child: NumCalendarApp(),
      ),
    );
