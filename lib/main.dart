import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/network/remote/DioHelper/dio_helper.dart';
import 'layouts/cubit/cubit.dart';
import 'layouts/home_module/homeModule.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..getData()..createDatabase()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeModule(),
        theme: ThemeData(
          backgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              elevation: 0,
          ),
        ),
      ),
    );
  }
}
