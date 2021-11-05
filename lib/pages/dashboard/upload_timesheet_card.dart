import 'package:flutter/material.dart';

class UploadTimeSheetCard extends StatelessWidget {
  int value = 0;
  UploadTimeSheetCard({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFF5c1ac3),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'upload-timesheet');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${value}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.waves_sharp,
                    color: Colors.white,
                  )
                ],
              ),
              Text(
                'Upload Timesheets',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
