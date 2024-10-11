import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // intl 패키지의 DateFormat 사용
import 'package:intl/date_symbol_data_local.dart'; // 로케일 데이터 초기화용

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  DateTime _today = DateTime.now();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(); // 로케일 데이터 초기화
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _buildDetailContent()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailContent() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 60, horizontal: 14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PLANNITY',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.search,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  TableCalendar(
                    locale: 'ko_KR',
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) {
                      return _selectedDay != null && isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay; // 날짜 선택
                        _focusedDay = focusedDay; // 포커스된 날짜 업데이트
                      });
                    },
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      weekendTextStyle: TextStyle(
                        color: Colors.red,
                      ),
                      todayTextStyle: TextStyle(color: Colors.black),
                    ),
                    enabledDayPredicate: (day) {
                      return day.isAfter(_today.subtract(Duration(days: 0))); // 다음 날부터 선택 가능
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
