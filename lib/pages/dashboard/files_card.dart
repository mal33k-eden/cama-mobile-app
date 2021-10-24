import 'package:flutter/material.dart';

class AllFilesCard extends StatelessWidget {
  const AllFilesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.pink),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'my-files');
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
                  '20',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.file_copy_sharp,
                  color: Colors.white,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('All Files',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
