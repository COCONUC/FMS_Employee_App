import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/screens/tab_booking.dart';
import 'package:fms_employee/screens/tab_day_off.dart';
import 'package:fms_employee/screens/tab_profile.dart';
import 'package:fms_employee/screens/tab_repair.dart';

class NavScreen extends StatefulWidget {
  static const String routeName = '/actual-home';
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {

  int currentIndex = 0;

  List<Widget> tabPages = const [
    TabBooking(),
    TabRepair(),
    TabDayOff(),
    TabProfile(),
  ];

  void updatePage(int page) {
    setState(() {
      currentIndex = page;
    });
  }
  @override
  void initState(){

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: tabPages[currentIndex],
      bottomNavigationBar: Row(
        children: <Widget>[
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.handyman, 1),
          buildNavBarItem(Icons.calendar_month, 2),
          buildNavBarItem(Icons.person, 3),
        ],
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        decoration: index == currentIndex
            ? BoxDecoration(
            border: const Border(
              bottom: BorderSide(width: 4, color: Colors.orangeAccent),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ))
            : const BoxDecoration(),
        child: Icon(
          icon,
          size: index == currentIndex ? 36 : 26,
          color: index == currentIndex ? Colors.redAccent : Colors.black,
        ),
      ),
    );
  }
} //end class _Nav
