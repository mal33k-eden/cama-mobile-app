import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cama/models/user.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/avart_icon.dart';
import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  User? user;
  late AuthProvider? _auth;
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().getUser();
    final _auth = Provider.of<AuthProvider>(context);

    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 0, 30),
      child: Column(
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child: IconButton(onPressed: () {}, icon: Icon(Icons.edit_sharp)),
          // ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  pickImage(ImageSource.gallery, _auth);
                },
                child: Stack(
                  children: [
                    (user!.photo == null)
                        ? ClipOval(
                            child: Image.asset(
                              'assets/images/avatar.jpg',
                              width: 100,
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(user.photo),
                            radius: 50,
                            backgroundColor: Colors.transparent,
                          ),
                    Positioned(
                      child: editImageIcon(),
                      bottom: 0,
                      left: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.first_name + ' ' + user.last_name,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(user.email,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w200)),
                  SizedBox(
                    height: 8,
                  ),
                  Text(user.agent_type,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('DOB',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(
                      (user.date_of_birth != null) ? user.date_of_birth : '---',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  Text('Mobile',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(user.mobile,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  Text('Postcode',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text((user.postcode != '') ? user.postcode : '---',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ],
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
    );
  }

  Future pickImage(ImageSource source, auth) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File file = File(image.path);
      Map<String, dynamic> body = {};
      body['photo'] = file;
      await auth.updateUser(body: body, token: auth.token);
      if (auth.isProfileUpdate) {}
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
