class LanguageModel{
  String langName;
  String langIsoCode;
  LanguageModel({required this.langIsoCode,required this.langName});
}

// Todo: made this to use in dropDownButton that on Profile screen which used to change language
List<LanguageModel> languageOptions =
[
  LanguageModel(langIsoCode: "en", langName: "english"),
  LanguageModel(langIsoCode: "ar", langName: "arabic"),
  LanguageModel(langIsoCode: "fr", langName: "french"),
];