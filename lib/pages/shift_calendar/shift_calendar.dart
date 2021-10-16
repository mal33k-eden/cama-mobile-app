import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ShiftCalendar extends StatefulWidget {
  const ShiftCalendar({Key? key}) : super(key: key);

  @override
  State<ShiftCalendar> createState() => _ShiftCalendarState();
}

class _ShiftCalendarState extends State<ShiftCalendar> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shift Calendar'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                focusedDay: focusedDay,
                firstDay: DateTime(2000),
                lastDay: DateTime(2050),
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekVisible: true,
                headerStyle: HeaderStyle(
                    titleTextStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    formatButtonVisible: false,
                    titleCentered: true),
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDate, day);
                },
                onDaySelected: (DateTime selectDate, DateTime focusDay) {
                  setState(() {
                    selectedDate = selectDate;
                    focusedDay = focusDay;
                  });
                },
                calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    todayDecoration: BoxDecoration(
                        color: Flavor.secondaryToDark, shape: BoxShape.circle),
                    selectedDecoration: BoxDecoration(
                        color: Flavor.primaryToDark, shape: BoxShape.circle),
                    selectedTextStyle: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                    color: Flavor.primaryToDark,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Today',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        ),
                        Divider(),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.home_sharp,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  Text(
                                    ' Ascot Homes',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.place_sharp,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'TS1 4PE, Ayresome Street',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Thu 2nd, Sep 2021',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer_sharp,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '08:00am - 08:00pm',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.business_sharp,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Goodwill Healthcare Service',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.text_snippet_sharp,
                                    color: Colors.white,
                                  ),
                                  Flexible(
                                    child: Text(
                                      ' One to one shift',
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
