import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layouts/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import '../../modules/ArchiveScreen/archiveScreen.dart';
import '../../modules/NewScreen/newsScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/profileScreen/profileScreen.dart';
import '../../shared/network/remote/DioHelper/dio_helper.dart';
class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());
  static AppCubit? cubit;
  static AppCubit get(BuildContext context){ return BlocProvider.of(context); }
  // This related to BottomNavigationBar
  int initialIndex = 0;
  void ChangeBottomNavIndex(int index){
    initialIndex = index ;
    emit(ChangeBottomNavState());
  }
  List<Widget> screens =
  [
    NewsScreen(),
    ArchiveScreen(),
    ProfileScreen()
  ];
  List<String> titleScreen = [ "News","Archive","Profile"];

  // this related to newsScreen about changeDropDownItem
  String selectedCountry = "eg";
  void changeSelectedCountry(String chosenCountry)
  {
  selectedCountry = chosenCountry;
  getData();
  emit(changeSelectedCountryState());
  }

  String selectedCategory = "general";
  void chooseCategory(String val)
  {
    selectedCategory = val;
    getData();
    emit(changeSelectedCategoryState());
  }

  // this related to get data from Api using Dio package 
  List mydata = [];
  void getData(){
    DioHelper.getDataFromAPi(
        methodUrl: 'v2/top-headlines',
        query:
        {
          'country' : selectedCountry,
          'category' : selectedCategory,
          'apiKey' : 'ab8bb5ffb10d447d8b68601d795194cd',
        }
        ).then((value)
        {
          mydata = value?.data['articles'];
          print(mydata);
          emit(GetDataFormApiState());
        });
  }
  
  // this related to Sqfite
  Database? db ;
  List<Map> archivedData = [];
  // 1. create Database & news table
  void createDatabase() async {
    db = await openDatabase(
      'news.db',
      version: 1,
      onCreate: (database,version)
        {
          database.execute("CREATE TABLE news (id INTEGER PRIMARY KEY, title TEXT, urlImage TEXT, publishedAt TEXT)").then((value)
          {
            emit(CreateDatabaseState());
            print("News Table created successfully");
          }).catchError((e)=>print("error during create table"));
        },
      onOpen: (database)
      {
        // get Data from Database Method & emit()
        getDatabase(database);
        print("News.db opened successfully");
      }
    );
  }
  // 2. Insert Data to news table
  void InsertTODatabase({
    required String title,
    required String urlToImage,
    required String publishedAt,
  })
  {
    db?.transaction((txn) async {
      txn.rawInsert('INSERT INTO news(title,urlImage,publishedAt) VALUES ("${title}","${urlToImage}","${publishedAt}")');
    }).then((val)
    {
      emit(InsertToDatabaseState());
      print("Data was inserted to Database are => ${val}");
      getDatabase(db!);
    }).catchError((e)=>print(e));
  }

  // 3. get Data form Database
  Future getDatabase(Database database)
  {
    return database.rawQuery("SELECT * FROM news").then((value)
    {
      archivedData = value;
      emit(GetDataFromDatabaseState());
      print(value);
    }).catchError((e)=>print("error during get data from database"));
  }
  // 4. delete item from database
  void DeleteDatebase({required int id}) {
    db?.rawUpdate(
        'DELETE FROM news WHERE id = ?',
        [id]
    ).then((value)
    {
      emit(DeletedItemFromDatabaseState());
      getDatabase(db!);
    }).catchError((e)=>print(e.toString()));
  }
}