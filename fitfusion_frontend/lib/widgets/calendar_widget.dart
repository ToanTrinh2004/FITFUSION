import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/contract_model.dart';
import '../theme/theme.dart';

class ScheduleCalendar extends StatefulWidget {
  final List<ContractModel> contracts;

  const ScheduleCalendar({Key? key, required this.contracts}) : super(key: key);

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List<ContractSchedule>> _events = {};

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _prepareEvents();
  }

  void _prepareEvents() {
    final Map<DateTime, List<ContractSchedule>> events = {};

    for (var contract in widget.contracts) {
      for (var schedule in contract.schedule) {
        // Map weekday (e.g., "Monday") to DateTime for the entire month
        final daysInMonth = _getAllDaysForWeekday(schedule.day, _focusedDay);
        for (final day in daysInMonth) {
          if (events[day] == null) {
            events[day] = [];
          }
          events[day]!.add(ContractSchedule(
            customerName: contract.customerName,
            time: schedule.time,
          ));
        }
      }
    }

    setState(() {
      _events = events;
    });
  }

  List<DateTime> _getAllDaysForWeekday(String weekday, DateTime focusedDay) {
    final List<DateTime> days = [];
    final weekdayIndex = _getWeekdayIndex(weekday);
    if (weekdayIndex == null) return days;

    // Iterate through all days of the focused month
    for (int i = 1; i <= DateTime(focusedDay.year, focusedDay.month + 1, 0).day; i++) {
      final date = DateTime(focusedDay.year, focusedDay.month, i);
      if (date.weekday == weekdayIndex) {
        days.add(date);
      }
    }

    return days;
  }

  int? _getWeekdayIndex(String weekday) {
    switch (weekday.toLowerCase()) {
      case 'monday':
        return DateTime.monday;
      case 'tuesday':
        return DateTime.tuesday;
      case 'wednesday':
        return DateTime.wednesday;
      case 'thursday':
        return DateTime.thursday;
      case 'friday':
        return DateTime.friday;
      case 'saturday':
        return DateTime.saturday;
      case 'sunday':
        return DateTime.sunday;
      default:
        return null;
    }
  }

  List<ContractSchedule> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _events[normalizedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2022, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          eventLoader: _getEventsForDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
              _prepareEvents(); // Recalculate events when month changes
            });
          },
          calendarStyle: CalendarStyle(
            markerDecoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            selectedDecoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            todayDecoration: const BoxDecoration(
              color: AppColors.primaryHalf,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonTextStyle: TextStyle(fontSize: 14),
            formatButtonDecoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            formatButtonShowsNext: false,
            titleCentered: true,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: _buildScheduleDetails(),
        ),
      ],
    );
  }

  Widget _buildScheduleDetails() {
    final events = _getEventsForDay(_selectedDay ?? DateTime.now());
    if (events.isEmpty) {
      return const Center(
        child: Text(
          "Không có lịch tập cho ngày này",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(
                event.customerName.substring(0, 1),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              event.customerName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              "Thời gian: ${event.time}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ContractSchedule {
  final String customerName;
  final String time;

  ContractSchedule({required this.customerName, required this.time});
}