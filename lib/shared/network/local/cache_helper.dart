import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPref;   // Todo: static to be created one time
  static cacheInitialization() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  // Todo: save Data on cache
  static Future<bool> saveCacheData({required String key,required dynamic value}) async {
    if( value is String )
    {
      await sharedPref!.setString(key, value);
      return true;
    }
    else if( value is double )
    {
      await sharedPref!.setDouble(key, value);
      return true;
    }
    else if( value is int )
    {
      await sharedPref!.setInt(key, value);
      return true;
    }
    else if( value is bool )
    {
      await sharedPref!.setBool(key, value);
      return true;
    }
    return false;
  }

  // Todo: get Data from Cache
  static Future<dynamic> getCacheData({required String key}) async {
    return sharedPref!.get(key);
  }

  // Todo : delete cache data
  static Future<bool> deleteCacheData() async {
    await sharedPref!.clear().then((value){
      if(value) return true;   // Todo: as clear() method return bool value
    });
    return false;
  }
}