import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MyLocalizations{
  final Locale? locale;
  Map<String,String>? jsonData;
  // Todo: Normal Constructor take a value for locale
  MyLocalizations({required this.locale});

  // Todo: make an object from my Main Delegate that I created
  static LocalizationsDelegate<MyLocalizations> delegate = _MyLocalizationsDelegates();

  // Todo: make an instance from Localizations<MyLocalizations>
  static MyLocalizations? getInstance({required BuildContext context}){
    return Localizations.of<MyLocalizations>(context,MyLocalizations);
    // Todo: Localizations.of<type>(context,type) => Returns the localized resources object of the given type for the widget tree that corresponds( تتوافق ) to the given context.
    // Todo: Returns null if no resources object of the given type exists within the given context.
  }

  // Todo: read json files
  Future<void> loadJsonFile() async {

    String jsonSource = await rootBundle.loadString("assets/lang/${locale!.languageCode}.json");    // throw the locale's value which be taken from constructor, I will get languageCode, will be one of ar or en

    // Todo: Decode json file
    Map<String,dynamic> jsonDecoded = jsonDecode(jsonSource);     // Todo: Parses the string and returns the resulting Json object.

    // Todo: converting jsonDecoded from string,dynamic to string,string as it actually is
    jsonData = jsonDecoded.map((key, value) => MapEntry(key, value.toString()));     /// mapName.map(()=> return MapEntry(key,value))  ... loop on map
  }
  // Todo: method to get the value from object that on json file for example en.json => for specific key
  String getValueFromJsonData({required String key}) => jsonData![key] ?? "empty";
}

class _MyLocalizationsDelegates extends LocalizationsDelegate<MyLocalizations>{
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ["en","ar","fr"].contains(locale.languageCode) ;    // if languageCode equal one of ar , en return true else false
  }

  @override
  Future<MyLocalizations> load(Locale locale) async {
    // TODO: implement load لتحميل ملفي ال json
    final MyLocalizations myLocalizations = MyLocalizations(locale: locale);
    await myLocalizations.loadJsonFile();
    return myLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<MyLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }

}