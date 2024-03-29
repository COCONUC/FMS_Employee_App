import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String prefName = "com.example.provider_man_app";
  static String introAvailable = "${prefName}isIntroAvailable";
  static String isLoggedIn = "${prefName}isLoggedIn";
  static String getTheme = "${prefName}isSelectedTheme";
  static String defIndexVal = "${prefName}index";
  static String getDefaultCode = "${prefName}code";
  static String getDefaultCountry = "${prefName}country";
  static String getServices = "${prefName}selectedServices";
  static String defCountryName = "image_albania.jpg";
  static String getAccountId = "${prefName}accountId";

  static Future<SharedPreferences> getPrefInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }
  static setDefCode(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(getDefaultCode, avail);
  }

  static setCountryName(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(getDefaultCountry, avail);
  }
  static setServices(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(getServices, avail);
  }
  static setUserId(int avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setInt(getAccountId, avail);
  }
  static Future<String> getServicesList() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable =
        preferences.getString(getServices) ?? getServices;
    return isIntroAvailable;
  }
  static Future<String> getDefCode() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable = preferences.getString(getDefaultCode) ?? "+1";
    return isIntroAvailable;
  }
  static Future<int> getUserId() async {
    SharedPreferences preferences = await getPrefInstance();
    int isIntroAvailable = preferences.getInt(getAccountId) ?? 0;
    return isIntroAvailable;
  }
  static Future<String> getDefCountry() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable =
        preferences.getString(getDefaultCountry) ?? defCountryName;
    return isIntroAvailable;
  }
  static setDefIndex(int avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setInt(defIndexVal, avail);
  }

  static setLogIn(bool avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setBool(isLoggedIn, avail);
  }

  static Future<int> getDefIndex() async {
    SharedPreferences preferences = await getPrefInstance();
    int isIntroAvailable = preferences.getInt(defIndexVal) ?? 0;
    return isIntroAvailable;
  }
  static Future<bool> isLogIn() async {
    SharedPreferences preferences = await getPrefInstance();
    bool isIntroAvailable = preferences.getBool(isLoggedIn) ?? false;
    return isIntroAvailable;
  }

}
