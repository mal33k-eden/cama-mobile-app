import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cama/shared/flavors.dart';
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

  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  Future<void> notifyEasyLogin() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title:
            '${Emojis.smile_face_with_hand_over_mouth} ${Emojis.smile_hugging_face} Welcome!',
        body: 'Happy to have you',
      ),
    );
  }
}
