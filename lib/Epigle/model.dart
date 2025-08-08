import 'dart:collection';

import 'package:call_log/call_log.dart';

class GroupedCallLog {
  final String name;
  final String number;
  final DateTime date;
  final int callCount;

  GroupedCallLog({
    required this.name,
    required this.number,
    required this.date,
    required this.callCount,
  });
}

List<List<CallLogEntry>> groupCallLogEntries(List<CallLogEntry> callLogEntries) {
  // Create a map to store grouped call log entries
  Map<String, List<CallLogEntry>> keyMap = {}; // Key is number+date
  Map<String, int> callCountMap = {}; // Key is number+date, value is call count

  // Iterate over callLogEntries to group by number and date
  for (var entry in callLogEntries) {
    var date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp!);
    String key = '${entry.number}_${date.year}-${date.month}-${date.day}';
      keyMap[key]!.add(entry);
  }

  // Convert keyMap to a list of lists
  List<List<CallLogEntry>> groupedCallLogEntries = keyMap.values.toList();

  return groupedCallLogEntries;
}