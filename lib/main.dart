import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cama/providers/provider_agency.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/providers/provider_dashboard.dart';
import 'package:cama/providers/provider_shift.dart';
import 'package:cama/services/push_config.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/providers/provider_file.dart';
import 'package:cama/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'routes.dart' as route;

int? isViewed;

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  isViewed = preferences.getInt('onBoard');
  await dotenv.load();
  PushNotifyConfig push = new PushNotifyConfig();
  push.init();
  HttpOverrides.global = new MyHttpOverrides();

  await Firebase.initializeApp();
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AuthProvider()),
      ChangeNotifierProvider.value(value: AgencyProvider()),
      ChangeNotifierProvider.value(value: FileProvider()),
      ChangeNotifierProvider.value(value: ShiftProvider()),
      ChangeNotifierProvider.value(value: DashBoardProvider()),
    ],
    child: CamaSplash(),
  ));
}

class CamaSplash extends StatefulWidget {
  @override
  _CamaSplash createState() => new _CamaSplash();
}

class _CamaSplash extends State<CamaSplash> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage('assets/logos/logo.png'), context);
    precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'assets/images/org_doc.svg'),
      context,
    );
    precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'assets/images/org_shifts.svg'),
      context,
    );
    precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'assets/images/nurse_home.svg'),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new SplashScreen(
            seconds: 3,
            navigateAfterSeconds: new MyApp(),
            title: new Text(
              'Do More With C.A.M.A',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Flavor.secondaryToDark),
            ),
            image: Image.asset('assets/logos/logo.png'),
            backgroundColor: Flavor.primaryToDark.shade400,
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 150.0,
            onClick: () => print("Flutter Egypt"),
            loaderColor: Flavor.secondaryToDark));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(_firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    //PushNotifyConfig().permission(context);
    PushNotifyConfig().permitFirebaseCM();
    PushNotifyConfig().listenForPush(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Flavor.primaryToDark,
          appBarTheme:
              AppBarTheme(backgroundColor: Flavor.primaryToDark, elevation: 0),
          primarySwatch: Flavor.primaryToDark,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: route.Controller,
        routes: {
          '/': (context) => Wrapper(),
        },
      ),
    );
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
    // Use this method to automatically convert the push data, in case you gonna use our data standard
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
