import 'package:flutter/material.dart';

class ShiftPoolCard extends StatelessWidget {
  const ShiftPoolCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFFe2a03f),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'shift-pool');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '100',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.waves_sharp,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Shift Pool',
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
