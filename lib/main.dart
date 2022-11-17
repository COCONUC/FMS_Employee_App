import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/providers/data_class.dart';
import 'package:fms_employee/screens/new_login_screen.dart';
import 'package:fms_employee/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:fms_employee/router.dart';



void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => AppState();
}

class AppState extends State<MyApp> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FMS',
      theme: ThemeData(
        scaffoldBackgroundColor: mBackgroundColor,
        colorScheme: const ColorScheme.light(
          primary: mSecondaryColor,
        ),
      ),

      onGenerateRoute: (settings) => generateRoute(settings),
      home: const LoginScreen(),
    );
  }

}