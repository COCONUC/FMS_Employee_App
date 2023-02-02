import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/router.dart';
import 'package:fms_employee/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('vi'),
      ],
      locale: const Locale('vi'),
      debugShowCheckedModeBanner: false,
      title: 'FMS',
      theme: ThemeData(
        scaffoldBackgroundColor: mBackgroundColor,
        colorScheme: const ColorScheme.light(
          primary: mSecondaryColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const SplashScreen(),
      //initialRoute: '/new-login-screen',
    );
  }

}