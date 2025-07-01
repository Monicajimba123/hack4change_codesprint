import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as nepali;

class CropCalendarScreen extends StatefulWidget {
  const CropCalendarScreen({super.key});

  @override
  State<CropCalendarScreen> createState() => _CropCalendarScreenState();
}

class _CropCalendarScreenState extends State<CropCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  final Map<DateTime, List<String>> _tasks = {};

  final TextEditingController _taskController = TextEditingController();

  List<String> _getTasksForDay(DateTime day) {
    return _tasks[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _addTask(String task) {
    final key =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    if (_tasks.containsKey(key)) {
      _tasks[key]!.add(task);
    } else {
      _tasks[key] = [task];
    }
    _taskController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final nepaliDate = nepali.NepaliDateTime.fromDateTime(_selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: const Text("बाली तालिका"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "📅 चयन गरिएको मिति: ${_selectedDay.year}-${_selectedDay.month}-${_selectedDay.day} (नेपाली: ${nepaliDate.format('yyyy-MM-dd')})",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: "कार्य थप्नुहोस् (जस्तै: पानी हाल्ने, मल हाल्ने)",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      _addTask(_taskController.text);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "📌 कार्य सूची:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: ListView(
                children: _getTasksForDay(_selectedDay)
                    .map((task) => ListTile(
                          leading: const Icon(Icons.task_alt),
                          title: Text(task),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
