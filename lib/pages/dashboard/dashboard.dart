import 'package:cama/pages/dashboard/agencies_card.dart';
import 'package:cama/pages/dashboard/files_card.dart';
import 'package:cama/pages/dashboard/shift_calendar_card.dart';
import 'package:cama/pages/dashboard/shift_pool_card.dart';
import 'package:cama/pages/dashboard/unconfirmed_shift_card.dart';
import 'package:cama/pages/dashboard/upload_timesheet_card.dart';
import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15,
                  color: Flavor.primaryToDark.shade50,
                  spreadRadius: 5),
              BoxShadow(
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15,
                  color: Colors.white10,
                  spreadRadius: 5),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2030),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'profile-summary');
              },
              child: CircleAvatar(
                radius: 25,
                child: Image.asset(
                  'assets/images/avatar.jpg',
                ),
              ),
            ),
          ),
        ),
        title: Text('C.A.M.A'),
        actions: [Icon(Icons.notifications_active_sharp)],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 30,
                ),
              ),
              Text(
                'John Doe',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Flavor.primaryToDark,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [Text('Tue'), Divider(), Text('23')],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Today\'s Shift',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '08:00am - 08:00pm',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Ascot Homes',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            'Goodwill Healthcare Service',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: [
                    ShiftCalendarCard(),
                    ShiftPoolCard(),
                    UnconfirmedShiftCard(),
                    UploadTimeSheetCard(),
                    AllFilesCard(),
                    AgenciesCard()
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
