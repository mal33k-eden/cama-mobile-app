// Control our page route flow
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
import 'package:cama/route_builder.dart';
import 'package:cama/wrapper.dart';
import 'package:flutter/material.dart';

Route<dynamic> Controller(RouteSettings settings) {
  switch (settings.name) {
    case 'dashboard':
      return CustomPageRoute(
        child: DashBoard(),
        settings: settings,
      );
    case 'change-otp-phone':
      return CustomPageRoute(
        child: ChangePhoneNumber(),
        settings: settings,
      );
    case 'verify-otp':
      return CustomPageRoute(
        child: OTPPage(),
        settings: settings,
      );
    case 'profile-summary':
      return CustomPageRoute(
        child: Summary(),
        settings: settings,
      );
    case 'profile-details':
      return CustomPageRoute(
        child: PersonalDetails(),
        settings: settings,
      );
    case 'profile-details-edit':
      return CustomPageRoute(
        child: UpdateProfileDetails(),
        settings: settings,
      );
    case 'background-checks':
      return CustomPageRoute(
        child: BackgroundChecks(),
        settings: settings,
      );
    case 'background-checks-edit':
      return CustomPageRoute(
        child: BackgroundChecksUpdate(),
        settings: settings,
      );
    case 'work-history':
      return CustomPageRoute(
        child: WorkHistory(),
        settings: settings,
      );
    case 'work-history-edit':
      return CustomPageRoute(
        child: UpdateWorkHistory(),
        settings: settings,
      );
    case 'qualification':
      return CustomPageRoute(
        child: Qualification(),
        settings: settings,
      );
    case 'qualification-edit':
      return CustomPageRoute(
        child: UpdateQualification(),
        settings: settings,
      );
    case 'nextofkin':
      return CustomPageRoute(
        child: NextOfKin(),
        settings: settings,
      );
    case 'nextofkin-edit':
      return CustomPageRoute(
        child: UpdateNextOfKin(),
        settings: settings,
      );
    case 'referee':
      return CustomPageRoute(
        child: Referee(),
        settings: settings,
      );
    case 'referee-edit':
      return CustomPageRoute(
        child: UpdateReferee(),
        settings: settings,
      );
    case 'agencies':
      return CustomPageRoute(
        child: AllAgencies(),
        settings: settings,
      );
    case 'agency-profile':
      return CustomPageRoute(
        child: AgencyProfile(),
        settings: settings,
      );
    case 'agency-documents':
      return CustomPageRoute(
        child: AgencyDocuments(),
        settings: settings,
      );
    case 'agency-trainings':
      return CustomPageRoute(
        child: AgencyTraining(),
        settings: settings,
      );
    case 'agency-policy':
      return CustomPageRoute(
        child: AgencyProfile(),
        settings: settings,
      );
    case 'shift-unconfirmed':
      return CustomPageRoute(
        child: UnconfimredShifts(),
        settings: settings,
      );
    case 'shift-pool':
      return CustomPageRoute(child: ShiftPool(), settings: settings);
    case 'shift-calendar':
      return CustomPageRoute(
        child: ShiftCalendar(),
        settings: settings,
      );
    case 'upload-timesheet':
      return CustomPageRoute(
        child: UploadTimeSheet(),
        settings: settings,
      );
    case 'my-files':
      return CustomPageRoute(
        child: MyFiles(),
        settings: settings,
      );
    case 'my-files-edit':
      return CustomPageRoute(
        child: UpdateFile(),
        settings: settings,
      );
    default:
      throw ('This route name does not exit');
  }
}
