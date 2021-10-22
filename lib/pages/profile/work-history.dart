import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class WorkHistory extends StatefulWidget {
  const WorkHistory({Key? key}) : super(key: key);

  @override
  State<WorkHistory> createState() => _WorkHistoryState();
}

class _WorkHistoryState extends State<WorkHistory> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = context.watch<AuthProvider>().getUser();
    List<dynamic> workHistory = user!.work_history;
    return Scaffold(
      appBar: AppBar(
        title: Text('Work History'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'work-history-edit',
                  arguments: {"wh": null});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: (workHistory.length > 0)
            ? ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                itemCount: workHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      InkWell(
                        onTap: () {
                          _showWorkHistoryDetails(
                              context, workHistory.elementAt(index));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            //padding: EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.badge_sharp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        workHistory.elementAt(index)['title'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.business_center_sharp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        workHistory
                                            .elementAt(index)['employer'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            workHistory
                                                .elementAt(index)['start_date'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            ' - ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            workHistory
                                                .elementAt(index)['end_date'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.note_sharp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          (workHistory.elementAt(
                                                      index)['leave_reason'] !=
                                                  null)
                                              ? workHistory.elementAt(
                                                  index)['leave_reason']
                                              : '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Flavor.primaryToDark,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(4.0, 4.0),
                                      blurRadius: 25,
                                      color: Colors.grey.shade300,
                                      spreadRadius: 8),
                                  BoxShadow(
                                      offset: Offset(-4.0, -4.0),
                                      blurRadius: 25,
                                      color: Colors.white10,
                                      spreadRadius: 8),
                                ]),
                          ),
                        ),
                      )
                    ],
                  );
                },
              )
            : SizedBox(),
      ),
    );
  }

  void move(Map details) {
    Navigator.pushNamed(context, 'work-history-edit',
        arguments: {'wh': details});
  }

  void _showWorkHistoryDetails(BuildContext context, Map details) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Work History'),
        scrollable: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Are your sure you want to make changes to this entery?'),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                move(details);
              },
              child: Text('Edit'))
        ],
      ),
    );
  }
}
