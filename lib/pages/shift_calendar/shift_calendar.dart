import 'package:cama/models/shift.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/providers/provider_shift.dart';
import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ShiftCalendar extends StatefulWidget {
  const ShiftCalendar({Key? key}) : super(key: key);

  @override
  State<ShiftCalendar> createState() => _ShiftCalendarState();
}

class _ShiftCalendarState extends State<ShiftCalendar> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late final ShiftProvider _shiftProvider;
  late final AuthProvider _authProvider;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, MyShift>>? _shifts = [];
  List<MyShift?> dayShift = [];
  List<MyShift?> buildShiftForDay = [];
  String? _displayDate;

  @override
  void initState() {
    _shifts?.length = 0;
    _shifts = [];
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _shiftProvider = Provider.of<ShiftProvider>(this.context, listen: false);
      _authProvider = Provider.of<AuthProvider>(this.context, listen: false);
      _getCalendarData();
    });
    _formatDateDisplay(selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyShift? _shift;
    if (buildShiftForDay.length > 0) {
      _shift = buildShiftForDay.elementAt(0);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Shift Calendar'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                eventLoader: _shiftForDay,
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
                onDaySelected: (
                  DateTime selectDate,
                  DateTime focusDay,
                ) {
                  setState(() {
                    selectedDate = selectDate;
                    focusedDay = focusDay;

                    _buildShiftForDay(selectedDate);
                    _formatDateDisplay(selectedDate);
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
                            _displayDate!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        ),
                        Divider(),
                        (buildShiftForDay.length > 0)
                            ? Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.home_sharp,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        Text(
                                          ' ${_shift?.home ?? ''}',
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
                                          ' ${_shift?.postcode ?? ''},${_shift?.address ?? ''}',
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
                                          ' ${_displayDate!}',
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
                                          ' ${_shift!.start} to ${_shift.end}',
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
                                          ' ${_shift.agency}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
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
                                            ' ${_shift.note}',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox()
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

  void _getCalendarData() async {
    if (mounted) {
      setState(() {
        buildShiftForDay = [];
      });
    }
    Map<String, dynamic> body = {};
    body['month'] = DateFormat('MM').format(selectedDate);
    await _shiftProvider.calendar(body: body, token: _authProvider.token!);
    if (_shiftProvider.isShiftLoaded) {
      if (mounted) {
        setState(() {
          _shifts = _shiftProvider.myCalendarShifts();
          _buildShiftForDay(selectedDate);
        });
      }
    }
  }

  List<dynamic> _shiftForDay(DateTime _date) {
    String dt = DateFormat('yyyy-MM-dd').format(_date);
    dayShift = [];
    _shifts!.forEach((element) {
      if (element.keys.elementAt(0) == dt) {
        dayShift.add(element[0]);
      }
    });
    return dayShift;
  }

  _buildShiftForDay(DateTime _date) {
    String dt = DateFormat('yyyy-MM-dd').format(_date);
    buildShiftForDay = [];
    _shifts!.forEach((element) {
      if (element.keys.elementAt(0) == dt) {
        buildShiftForDay.add(element.values.elementAt(0));
      }
    });
    setState(() {
      buildShiftForDay;
    });
  }

  void _formatDateDisplay(DateTime selectedDate) {
    var now = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var selectd = DateFormat('yyyy-MM-dd').format(selectedDate);

    if (now == selectd) {
      _displayDate = 'Today';
    } else {
      _displayDate = DateFormat.yMMMEd().format(selectedDate);
    }

    setState(() {
      _displayDate;
    });
  }
}
