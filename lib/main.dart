import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/layouts/layout_screen/layout_screen.dart';
import 'package:news_app/shared/component/constants.dart';
import 'package:news_app/shared/localizations.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/theme/theme.dart';
import 'layouts/cubit/bloc_observer.dart';
import 'layouts/cubit/layout_cubit.dart';
import 'layouts/cubit/layout_states..dart';
import 'modules/HomeScreen/home_cubit/home_cubit.dart';
import 'modules/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.cacheInitialization();
  currentLocaleApp = Locale(await CacheHelper.getCacheData(key: "current_locale_app")?? "en");
  isDark = await CacheHelper.getCacheData(key: "isDark") ?? false ;
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (BuildContext context) => LayoutCubit()),
        BlocProvider(create: (BuildContext context) => HomeCubit()..getNews(country: 'eg', category: 'general')..createDatabase()),
      ],
      child: BlocBuilder<LayoutCubit,LayoutStates>(
        buildWhen: (previousState,currentState){
          return currentState is ChangeAppLanguageSuccessState || currentState is ChangeAppThemeSuccessState ;
        },
        builder: (context,state)
        {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context , child) {
              return MaterialApp(
                locale: currentLocaleApp,    // Todo: actually App's language ( which will passed to my delegate to get json files )
                supportedLocales: const
                [
                  Locale("ar"),
                  Locale("en","US"),
                  Locale("fr"),
                ],
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,                                 // Todo: get the directions for names for specific widgets depending on Device language
                  GlobalCupertinoLocalizations.delegate,                                // Todo: get the directions for names for specific widgets depending on Device language
                  GlobalWidgetsLocalizations.delegate,                                  // Todo: get the directions for widgets depending on Device language
                  MyLocalizations.delegate,                                             // Todo: Calling The Delegate which I created to load data from json files
                ],
                localeResolutionCallback : (deviceLocale,supportedLocales) {
                  for( var locale in supportedLocales )
                  {
                    if( locale.languageCode == deviceLocale!.languageCode ) return deviceLocale;
                  }
                  return supportedLocales.first;
                },
                debugShowCheckedModeBanner: false,
                home: child,
                theme: isDark ? darkTheme : lightTheme,
              );
            },
            child: SplashScreen(),
          );
        }
      )
    );
  }
}
