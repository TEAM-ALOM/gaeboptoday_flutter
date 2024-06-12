import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaeboptoday_flutter/screens/cards/added_menu_card.dart';
import 'package:gaeboptoday_flutter/screens/cards/menu_card.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthlyView extends StatefulWidget {
  const MonthlyView({super.key});

  @override
  State<MonthlyView> createState() => _MonthlyViewState();
}

class _MonthlyViewState extends State<MonthlyView> {
  final now = DateTime.now();
  var _focusedDay = DateTime.now();
  late int month, day;
  @override
  void initState() {
    month = int.parse(DateFormat('M').format(now));
    day = int.parse(DateFormat('d').format(now));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: TableCalendar(
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              locale: 'ko-kr',
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonTextStyle:
                    TextStyle(color: Colors.white, fontSize: 13),
                formatButtonDecoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.fromBorderSide(
                        BorderSide(color: Colors.blue, width: 2)),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                    color: Colors.blueAccent, shape: BoxShape.circle),
                todayTextStyle: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold),
                todayDecoration: BoxDecoration(
                    color: Colors.transparent, shape: BoxShape.circle),
                isTodayHighlighted: true,
                weekendTextStyle:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                outsideDaysVisible: false,
              ),
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = selectedDay;
                  month = int.parse(DateFormat('M').format(selectedDay));
                  day = int.parse(DateFormat('d').format(selectedDay));
                });
              },
              // onPageChanged: (focusedDay) {
              //   _focusedDay = focusedDay;
              // },
            ),
          ),
          Expanded(
            child: SizedBox(
                width: double.infinity,
                child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(248, 248, 248, 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: addedMenuCard({'lunch': [], 'dinner': []}),
                    ))),
          ),
        ],
      ),
    );
  }
}
