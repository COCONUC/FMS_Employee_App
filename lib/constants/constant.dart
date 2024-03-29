import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Constant {
  static String assetImagePath = "assets/images/";
  static String networkImagePath = "https://firebasestorage.googleapis.com";
  static bool isDriverApp = false;
  static const String fontsFamily = "Lato";
  static const String fromLogin = "getFromLoginClick";
  static const String homePos = "getTabPos";
  static const int stepStatusNone=0;
  static const int stepStatusActive=1;
  static const int stepStatusDone=2;
  static const int stepStatusWrong=3;

  static sendToNextWithRes(BuildContext context, String route,
      {Object? arguments, Function? fun}) {
    if (arguments != null) {
      Navigator.pushNamed(context, route, arguments: arguments).then((value) {
        if (fun != null) {
          fun();
        }
      });
    } else {
      Navigator.pushNamed(context, route).then((value) {
        if (fun != null) {
          fun();
        }
      });
    }
  }

  static double getPercentSize(double total, double percent) {
    return (percent * total) / 100;
  }

  static backToPrev(BuildContext context) {
    Navigator.of(context).pop();
  }

  static backToPrevAfterDelete(BuildContext context, bool bool) {
    Navigator.of(context).pop(bool);
  }

  static  getCurrency(BuildContext context) {
    return "ETH";
  }

  static sendToNext(BuildContext context, String route, {Object? arguments}) {
    if (arguments != null) {
      Navigator.pushNamed(context, route, arguments: arguments);
    } else {
      Navigator.pushNamed(context, route);
    }
  }

  static double getToolbarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + kToolbarHeight;
  }

  static double getToolbarTopHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static sendToScreen(Widget widget, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  static backToFinish(BuildContext context) {
    Navigator.of(context).pop();
  }

  static closeApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  static String? validateCharacters(String txt, String? title) {
    if (title == 'Số điện thoại' &&
        !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(txt)) {
      return 'Số điện thoại không đúng định dạng';
    }
    if (title == 'Mật khẩu' && txt.length < 8) {
      return "Mật khẩu phải từ 8 ký tự";
    }
    if (txt.isEmpty) {
      return "Trống!";
    }
    return null;
  }

}
