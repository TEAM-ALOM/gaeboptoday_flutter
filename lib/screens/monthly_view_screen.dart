import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gaeboptoday_flutter/controllers/server_request.dart';
import 'package:gaeboptoday_flutter/screens/cards/added_menu_card.dart';
import 'package:gaeboptoday_flutter/screens/cards/menu_card.dart';
import 'package:gaeboptoday_flutter/screens/cards/no_data_card.dart';
import 'package:gaeboptoday_flutter/screens/home_screen.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthlyView extends StatefulWidget {
  const MonthlyView({super.key});

  @override
  State<MonthlyView> createState() => _MonthlyViewState();
}

class _MonthlyViewState extends State<MonthlyView> {
  int dateIndex = 1;
  final now = DateTime.now();
  var _focusedDay = DateTime.now();
  late int month, day;
  final SwiperController _swiperController = SwiperController();

  late int timeCalculate;
  late StreamSubscription<InternetConnectionStatus> listener;
  late Map<String, List<String>> menuToday;

  @override
  void dispose() {
    // listener.cancel();
    super.dispose();
  }

  @override
  void initState() {
    month = int.parse(DateFormat('M').format(now));
    day = int.parse(DateFormat('d').format(now));
    super.initState();
    waitForInternet();
  }

  List<Card> cardWidgetList = [];
  void waitForInternet() async {
    setState(() {
      cardWidgetList = [
        Card(
          child: LoadingAnimationWidget.inkDrop(
            color: Colors.blueAccent,
            size: 30,
          ),
        ),
        Card(
          child: LoadingAnimationWidget.inkDrop(
            color: Colors.blueAccent,
            size: 30,
          ),
        ),
        Card(
          child: LoadingAnimationWidget.inkDrop(
            color: Colors.blueAccent,
            size: 30,
          ),
        ),
      ];
    });
    print(month);
    print(day);
    dataLoad();
    // listener = InternetConnectionChecker().onStatusChange.listen(
    //   (InternetConnectionStatus status) {
    //     switch (status) {
    //       case InternetConnectionStatus.connected:
    //         print('Data connection is available.');
    //         dataLoad();
    //         break;
    //       case InternetConnectionStatus.disconnected:
    //         internetDisconnected();
    //         print('You are disconnected from the internet.');
    //         break;
    //     }
    //   },
    // );
  }

  void internetDisconnected() {
    setState(() {
      cardWidgetList = [
        noDataCard(icon: "⚠️", text: "인터넷이 연결을 확인해주세요"),
        noDataCard(icon: "⚠️", text: "인터넷이 연결을 확인해주세요"),
        noDataCard(icon: "⚠️", text: "인터넷이 연결을 확인해주세요"),
      ];
    });
  }

  void dataLoad() async {
    menuToday = await getMenuData(month, day);
    // menuToday = await getMenuData(
    //     int.parse(formattedDate['month']!), int.parse(formattedDate['day']!));
    setState(() {
      print(menuToday['lunch']);

      cardWidgetList[0] =
          noDataCard(icon: "🙅🏻‍♂️", text: "현재 천원의 아침밥은 식단표 제공이 되지 않습니다.");
      cardWidgetList[1] = menuToday['lunch']!.isNotEmpty
          ? menuCard(menuToday['lunch']!, 3.9)
          : noDataCard(
              icon: "👩🏻‍🍳",
              text: "식당 휴무일 이거나 식단이 등록되지 않았습니다.",
              secondText: "계절밥상은 토요일, 일요일, 공휴일에 쉽니다.",
            );
      cardWidgetList[2] = menuToday['dinner']!.isNotEmpty
          ? menuCard(menuToday['dinner']!, 4.4)
          : noDataCard(
              icon: "👨🏻‍🍳",
              text: "식당 휴무일 이거나 식단이 등록되지 않았습니다.",
              secondText: "계절밥상은 토요일, 일요일, 공휴일에 쉽니다.",
            );
    });
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
                  print("asdasd");
                  waitForInternet();
                });
              },
            ),
          ),
          Expanded(
            child: SizedBox(
                width: double.infinity,
                child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(248, 248, 248, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Center(
                            child: AnimatedToggleSwitch<int>.size(
                              current: dateIndex,
                              values: const [0, 1, 2],
                              iconOpacity: 0.3,
                              height: 40,
                              indicatorSize: const Size.fromWidth(80),
                              customIconBuilder: (context, local, global) {
                                final text =
                                    const ['아침', '점심', '저녁'][local.index];
                                return Center(
                                    child: Text(
                                  text,
                                  style: TextStyle(
                                    fontSize:
                                        dateIndex != local.index ? 10 : 10,
                                    color: Color.lerp(Colors.black,
                                        Colors.white, local.animationValue),
                                    fontWeight: dateIndex != local.index
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                  ),
                                ));
                              },
                              borderWidth: 2.0,
                              iconAnimationType: AnimationType.onHover,
                              style: ToggleStyle(
                                backgroundColor: Colors.white,
                                borderColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: [],
                              ),
                              styleBuilder: (i) =>
                                  ToggleStyle(indicatorColor: colorBuilder(i)),
                              onChanged: (i) => setState(() {
                                dateIndex = i;
                                _swiperController.move(dateIndex);
                                // listener.cancel();
                              }),
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: Swiper(
                                loop: false,
                                itemBuilder: (BuildContext context, int index) {
                                  return cardWidgetList[index];
                                },
                                onIndexChanged: (v) => setState(() {
                                  dateIndex = v;
                                }),
                                index: dateIndex,
                                itemCount: cardWidgetList.length,
                                viewportFraction: 1,
                                scale: 0.8,
                                controller: _swiperController,
                              ),
                            ),
                          ),
                          // const Gap(10),
                        ],
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}
