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

  bool isNepali = true; // 🔥 Language toggle

  String getText({required String en, required String ne}) {
    return isNepali ? ne : en;
  }

  List<String> _getTasksForDay(DateTime day) {
    return _tasks[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _addTask(String task) {
    final key = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    if (_tasks.containsKey(key)) {
      _tasks[key]!.add(task);
    } else {
      _tasks[key] = [task];
    }
    _taskController.clear();
    setState(() {});
  }

  void _deleteTask(String task) {
    final key = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    _tasks[key]?.remove(task);
    if (_tasks[key]?.isEmpty ?? false) {
      _tasks.remove(key);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final nepaliDate = nepali.NepaliDateTime.fromDateTime(_selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: Text(getText(en: "Crop Calendar", ne: "बाली तालिका")),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: getText(en: 'Change Language', ne: 'भाषा परिवर्तन गर्नुहोस्'),
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
              });
            },
          ),
        ],
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
              "📅 ${getText(en: 'Selected Date', ne: 'चयन गरिएको मिति')}: "
              "${_selectedDay.year}-${_selectedDay.month}-${_selectedDay.day} "
              "(${getText(en: 'Nepali', ne: 'नेपाली')}: ${nepaliDate.format('yyyy-MM-dd')})",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: getText(
                  en: "Add Task (e.g. Watering, Fertilizing)",
                  ne: "कार्य थप्नुहोस् (जस्तै: पानी हाल्ने, मल हाल्ने)",
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_taskController.text.trim().isNotEmpty) {
                      _addTask(_taskController.text.trim());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "📌 ${getText(en: 'Task List', ne: 'कार्य सूची')}:",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: _getTasksForDay(_selectedDay).isEmpty
                  ? Center(
                      child: Text(
                        getText(en: "No tasks for this day", ne: "यो मितिमा कुनै कार्य छैन"),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView(
                      children: _getTasksForDay(_selectedDay)
                          .map(
                            (task) => Card(
                              child: ListTile(
                                leading: const Icon(Icons.task_alt, color: Colors.green),
                                title: Text(task),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text(getText(en: "Delete Task?", ne: "कार्य हटाउनुहोस्?")),
                                        content: Text(getText(
                                          en: "Are you sure you want to delete this task?",
                                          ne: "के तपाईं यो कार्य हटाउन निश्चित हुनुहुन्छ?",
                                        )),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(ctx),
                                            child: Text(getText(en: "Cancel", ne: "रद्द गर्नुहोस्")),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _deleteTask(task);
                                              Navigator.pop(ctx);
                                            },
                                            child: Text(
                                              getText(en: "Delete", ne: "हटाउनुहोस्"),
                                              style: const TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
