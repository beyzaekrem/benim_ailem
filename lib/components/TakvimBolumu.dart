import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:benim_ailem/pages/home_page/tum_etkinlikler_sayfasi.dart';

class TakvimBolumu extends StatefulWidget {
  const TakvimBolumu({super.key});

  @override
  State<TakvimBolumu> createState() => _TakvimBolumuState();
}

class _TakvimBolumuState extends State<TakvimBolumu> {
  DateTime _selectedDay = DateTime.now();

  Map<DateTime, List<String>> _etkinlikler = {
    DateTime.utc(2025, 7, 22): ['Temizlik Kampanyası'],
    DateTime.utc(2025, 7, 24): ['Seminer', 'Film Gösterimi'],
  };

  List<String> _getEventsForDay(DateTime day) {
    return _etkinlikler[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  void _showEtkinlikPopup(BuildContext context, DateTime selectedDay) {
    final etkinlikler = _getEventsForDay(selectedDay);
    if (etkinlikler.isEmpty) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "${selectedDay.day}.${selectedDay.month}.${selectedDay.year} Etkinlikleri",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: etkinlikler
              .map((e) => ListTile(
                    leading: const Icon(Icons.event, color: Color(0xFFFEB716)),
                    title: Text(e),
                  ))
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Kapat"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık + Tümü
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Etkinlikler',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFEB716),
                    ),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: 90,
                    height: 4,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFFFEB716),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TumEtkinliklerSayfasi()),
                  );
                },
                child: Row(
                  children: const [
                    Icon(Icons.grid_view, size: 20, color: Color(0xFFFEB716)),
                    SizedBox(width: 4),
                    Text(
                      'Tümü',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFEB716),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Takvim
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
              });
              _showEtkinlikPopup(context, selected);
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: const Color(0xFFFFDEA5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: const Color(0xFFFEB716),
                shape: BoxShape.circle,
              ),
              markerDecoration: const BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              leftChevronIcon: const Icon(Icons.chevron_left),
              rightChevronIcon: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}
