import 'package:flutter/material.dart';
import 'package:fms_employee/screens/new_login_screen.dart';
import 'package:fms_employee/screens/login_screen.dart';
import 'package:fms_employee/screens/notification_screen.dart';
import 'package:fms_employee/screens/order/booking_add_detail_screen.dart';
import 'package:fms_employee/screens/profile/my_profile_screen.dart';
import 'package:fms_employee/screens/staff_home_page.dart';
import 'package:fms_employee/screens/tab_day_off.dart';
import 'package:fms_employee/screens/tab_profile.dart';
import 'package:fms_employee/widgets/bottom_bar.dart';
import 'package:fms_employee/screens/tab_booking.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case NewLoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NewLoginScreen(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    /*case TabBooking.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TabBooking(),
      );*/
    case TabDayOff.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TabDayOff(),
      );
    /*case DetailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DetailScreen(),
      );*/
    /*case TabProfile.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TabProfile(),
      );*/
    /*case MyProfileScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyProfileScreen(),
      );*/
    case StaffHomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const StaffHomePage(),
      );
    case NavScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NavScreen(),
      );
    case NotificationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NotificationScreen(),
      );
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Trang không tồn tại'),
            ),
          ));
  }
}
