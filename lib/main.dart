import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cama/pages/agency/all.dart';
import 'package:cama/pages/agency/detail.dart';
import 'package:cama/pages/agency/documents.dart';
import 'package:cama/pages/agency/training.dart';
import 'package:cama/pages/auth/changephonenumber.dart';
import 'package:cama/pages/auth/otp.dart';
import 'package:cama/pages/dashboard/dashboard.dart';
import 'package:cama/pages/files/myfiles.dart';
import 'package:cama/pages/files/update_file.dart';
import 'package:cama/pages/profile/backround_checks.dart';
import 'package:cama/pages/profile/details.dart';
import 'package:cama/pages/profile/forms/background_checks_update.dart';
import 'package:cama/pages/profile/forms/nextofkin_update.dart';
import 'package:cama/pages/profile/forms/profile_update.dart';
import 'package:cama/pages/profile/forms/qualification_update.dart';
import 'package:cama/pages/profile/forms/referee_update.dart';
import 'package:cama/pages/profile/forms/work_history_update.dart';
import 'package:cama/pages/profile/nextofkin.dart';
import 'package:cama/pages/profile/qualifications.dart';
import 'package:cama/pages/profile/referee.dart';
import 'package:cama/pages/profile/summary.dart';
import 'package:cama/pages/profile/work-history.dart';
import 'package:cama/pages/shift_calendar/shift_calendar.dart';
import 'package:cama/pages/shiftpool/shift_pool.dart';
import 'package:cama/pages/shifts_u/unconfirmed_shifts.dart';
import 'package:cama/pages/timesheet/upload_timesheet.dart';
import 'package:cama/providers/provider_agency.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/providers/provider_shift.dart';
import 'package:cama/services/push_config.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/providers/provider_file.dart';
import 'package:cama/widgets/onboarding.dart';
import 'package:cama/wrapper.dart';
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
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AuthProvider()),
      ChangeNotifierProvider.value(value: AgencyProvider()),
      ChangeNotifierProvider.value(value: FileProvider()),
      ChangeNotifierProvider.value(value: ShiftProvider()),
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    PushNotifyConfig().permission(context);
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
            appBarTheme: AppBarTheme(
                backgroundColor: Flavor.primaryToDark, elevation: 0),
            primarySwatch: Flavor.primaryToDark,
            textTheme: GoogleFonts.quicksandTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: route.Controller,
          routes: {
            '/': (context) => isViewed != 0 ? Onboard() : Wrapper(),
            // 'change-otp-phone': (context) => ChangePhoneNumber(),
            // 'verify-otp': (context) => OTPPage(),
            // 'profile-summary': (context) => Summary(),
            // 'profile-details': (context) => PersonalDetails(),
            // 'profile-details-edit': (context) => UpdateProfileDetails(),
            // 'background-checks': (context) => BackgroundChecks(),
            // 'background-checks-edit': (context) => BackgroundChecksUpdate(),
            // 'work-history': (context) => WorkHistory(),
            // 'work-history-edit': (context) => UpdateWorkHistory(),
            // 'qualification': (context) => Qualification(),
            // 'qualification-edit': (context) => UpdateQualification(),
            // 'nextofkin': (context) => NextOfKin(),
            // 'nextofkin-edit': (context) => UpdateNextOfKin(),
            // 'referee': (context) => Referee(),
            // 'referee-edit': (context) => UpdateReferee(),
            // 'agencies': (context) => AllAgencies(),
            // 'agency-profile': (context) => AgencyProfile(),
            // 'agency-documents': (context) => AgencyDocuments(),
            // 'agency-trainings': (context) => AgencyTraining(),
            // 'agency-policy': (context) => AgencyProfile(),
            // 'shift-unconfirmed': (context) => UnconfimredShifts(),
            // 'shift-pool': (context) => ShiftPool(),
            // 'shift-calendar': (context) => ShiftCalendar(),
            // 'upload-timesheet': (context) => UploadTimeSheet(),
            // 'my-files': (context) => MyFiles(),
            // 'my-files-edit': (context) => UpdateFile(),
          }),
    );
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
