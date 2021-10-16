import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UploadTimeSheet extends StatelessWidget {
  const UploadTimeSheet({Key? key}) : super(key: key);

  // USD
  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    var format =
        NumberFormat.simpleCurrency(locale: locale.toString(), name: 'GBP');
    var cur = format.currencySymbol;

    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.tune_sharp)],
        title: Text('Upload TimeSheets'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
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
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Flavor.secondaryToDark,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(cur + ' 9.23'),
                          Divider(),
                          Text('11 Hrs')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.home_sharp),
                              Text(
                                'Ascot Homes',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.place_sharp),
                              Text(
                                'TS1 4PE, Ayresome Street',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_today),
                              Text('Thu 2nd, Sep 2021'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.timer_sharp),
                              Text('08:00am - 08:00pm'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.business_sharp),
                              Text(
                                'Goodwill Healthcare Service',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.upload_file_sharp,
                                      color: Flavor.secondaryToDark),
                                  label: Text(
                                    'Upload Timesheet',
                                    style: TextStyle(
                                        color: Flavor.secondaryToDark),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
