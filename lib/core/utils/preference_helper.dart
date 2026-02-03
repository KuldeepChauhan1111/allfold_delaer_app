import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  // static const String LOGIN_DATA = "LOGIN_DATA";
  // static const String IS_SIGN_IN = "IS_SIGN_IN";
  // static const String AUTH_TOKEN = "AUTH_TOKEN";
  // static const String FCM_TOKEN = "FCM_TOKEN";

  // static const String DEVICE_ID = "DEVICE_ID";
  static const String IS_LOGIN = "isLogin";
  static const String USER_DATA = "userData";
  static const String USER_ID = "userId";
  static const String USER_TYPE_ID = "userTypeId";
  static const String CART_MODEL_LIST_AD = "cartModelListAD";
  static const String CART_MODEL_LIST = "cartModelList";

  static SharedPreferences? _prefs;
  static Map<String, dynamic> _memoryPrefs = Map<String, dynamic>();

  static Future<SharedPreferences?> load() async {
    print("loaded2");
    print("loaded2 $_prefs");
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs;
  }

  static void setString(String key, String value) {
    _prefs?.setString(key, value);
    _memoryPrefs[key] = value;
  }

  static void remove(String? key){
    if(key != null){
      _prefs?.remove(key);
      _memoryPrefs[key] = null;
    }
  }
  static bool containsKey(String? key){
    bool doesContain = false;
    if(key != null){
      doesContain = _prefs?.containsKey(key) ?? false;
    }
    return doesContain;
  }

  static void setObject<T>(String key, dynamic value) {
    JsonEncoder encoder = const JsonEncoder();
    _prefs?.setString(key, encoder.convert(value));
    _memoryPrefs[key] = encoder.convert(value);
  }

  static void setInt(String key, int value) {
    _prefs?.setInt(key, value);
    _memoryPrefs[key] = value;
  }

  static void setDouble(String key, double value) {
    _prefs?.setDouble(key, value);
    _memoryPrefs[key] = value;
  }

  static void setBool(String key, bool value) {
    _prefs?.setBool(key, value);
    _memoryPrefs[key] = value;
  }

  static String? getString(String key, {String? def}) {
    String? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs?.getString(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static int? getInt(String key, {int? def}) {
    int? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs?.getInt(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static double? getDouble(String key, {double? def}) {
    double? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs?.getDouble(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static bool getBool(String key, {bool def = false}) {
    bool? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs?.getBool(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static dynamic getObject(String key) {
    String? val = getString(key, def: "");

    if (val != null) {
      JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(val);
    }
    return "";
  }

  static void clear() {
    _memoryPrefs.clear();
    _prefs?.clear();
  }
}
