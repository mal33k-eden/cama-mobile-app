import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cama/shared/flavors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotifyConfig {
  void init() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/res_logo.png',
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Flavor.secondaryToDark,
              channelShowBadge: true,
              importance: NotificationImportance.High,
              ledColor: Colors.white)
        ]);
  }

  void permission(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Allow Notifications'),
                  content: Text(
                      'C.A.M.A will only send you notifications when neccessary.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Don\t Allow',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )),
                    TextButton(
                        onPressed: () {
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((value) => Navigator.pop(context));
                        },
                        child: Text(
                          'Allow',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ));
      }
    });
  }

  void listenForPush(BuildContext context) {
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      if (receivedNotification.channelKey == 'basic_channel' &&
          Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then((value) {
          if (value > 0) {
            return AwesomeNotifications().setGlobalBadgeCounter(value - 1);
          }
        });
      }
    });
  }

  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  Future<void> notifyEasyLogin(action) async {
    String login =
        '${Emojis.smile_face_with_hand_over_mouth} ${Emojis.smile_hugging_face} Welcome Back!';
    String register =
        '${Emojis.smile_face_with_hand_over_mouth} ${Emojis.smile_hugging_face} Welcome!';
    String logout = '${Emojis.smile_face_without_mouth}  Signed Out!';
    String loginMsg =
        'Convinietly accept shifts and submit timesheets at any time & and where! Leggo!';
    String regMsg = 'Let\'s get you quickly setup!';
    String logoutMsg =
        'That means, you would not be updated on any booked or available shifts';
    String title = '';
    String msg = '';

    if (action == 'login') {
      title = login;
      msg = loginMsg;
    }
    if (action == 'register') {
      title = register;
      msg = regMsg;
    }
    if (action == 'logout') {
      title = logout;
      msg = logoutMsg;
    }
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: msg,
      ),
    );
  }

  void permitFirebaseCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> pickFromPool(action) async {
    String declined = '${Emojis.symbols_cross_mark} You Missed It!';
    String picked = '${Emojis.symbols_check_mark_button}  You Picked It!';
    String declineMsg =
        'Sorry! Shift Not Available. Shift picked by another staff.';
    String pickedMsg =
        'You picked this shift!. You will get a your confirmation shortly';
    String title = '';
    String msg = '';

    if (action == 'picked') {
      title = picked;
      msg = pickedMsg;
    } else {
      title = declined;
      msg = declineMsg;
    }
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: msg,
      ),
    );
  }

  Future<void> shiftConfirmation(action) async {
    String declined = '${Emojis.symbols_cross_mark} Shift Declined!';
    String picked = '${Emojis.symbols_check_mark_button}  Shift Confirmed!';
    String declineMsg = 'Your agency will be notified of your decision.';
    String pickedMsg =
        'You have confirmed your availabilty for this shift. An acceptance email will be sent to you shortly';
    String title = '';
    String msg = '';

    if (action == 'picked') {
      title = picked;
      msg = pickedMsg;
    } else {
      title = declined;
      msg = declineMsg;
    }
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: msg,
      ),
    );
  }

  Future<void> timesheetUpload() async {
    String title = '${Emojis.symbols_check_mark_button} Timesheet Uploaded!';
    String msg = 'You have successfully uploaded your timesheet.';

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: msg,
      ),
    );
  }
}
