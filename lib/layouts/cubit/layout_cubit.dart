import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/cubit/layout_states..dart';
import '../../modules/ArchiveScreen/archiveScreen.dart';
import '../../modules/HomeScreen/homeScreen.dart';
import '../../modules/profileScreen/profileScreen.dart';
import '../../shared/component/constants.dart';
import '../../shared/network/local/cache_helper.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit() : super(InitialLayoutState());

  static LayoutCubit getInstance(BuildContext context){ return BlocProvider.of<LayoutCubit>(context); }  // Todo: get instance from this cubit

  // Todo: related to App language
  Future<void> changeAppLanguage({required Locale locale}) async {
    await CacheHelper.saveCacheData(key: "current_locale_app",value: locale.languageCode).then((value){
      if( value == true )
      {
        currentLocaleApp = Locale(locale.languageCode);
        emit(ChangeAppLanguageSuccessState());
      }
      else
      {
        emit(ChangeAppLanguageErrorState());
      }
    });
  }

  // Todo: change the theme
  Future<void> changeAppTheme({required bool newValue}) async {
    await CacheHelper.saveCacheData(key: "isDark", value: newValue).then((value){
      isDark = newValue;
      emit(ChangeAppThemeSuccessState());
    }).catchError((error){
      debugPrint("Error during change The Theme, reason is $error");
      emit(ChangeAppThemeErrorState());
    });
  }

  // Todo: This related to BottomNavigationBar
  int currentIndexForBottomNav = 0;

  void changeBottomNavIndex(int index){
    currentIndexForBottomNav = index ;
    emit(ChangeBottomNavState());
  }

  List<Widget> screens = [
    NewsScreen(),
    ArchiveScreen(),
    ProfileScreen()
  ];

  // Todo: this related to newsScreen about changeDropDownItem
  String country = "eg";
  String category = "general";
  void selectCountry(String val) {
    country = val;
    // Todo: need to implement it getNews(country: country,category: category);
    emit(ChangeSelectedCountryState());
  }

  void selectCategory(String val) {
    category = val;
    // Todo: need to implement it getNews(country: country,category: category);
    emit(ChangeSelectedCategoryState());
  }

}