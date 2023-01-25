import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'homeStates.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialAppState());
  static HomeCubit? cubit;
  static HomeCubit getInstance(BuildContext context){ return BlocProvider.of<HomeCubit>(context); }  // Todo: get instance from this cubit

  // this related to get data from Api using Dio package
  List newsData = [];
  void getNews({required String country,required String category}){
    emit(LoadingDuringGettingDataFromApi());
    DioHelper.getNetworkData(
        methodUrl: 'v2/top-headlines',
        query:
        {
          'country' : country,
          'category' : category,
          'apiKey' : '5dc516f347c946aa8b406da2764c066d',
        }
    ).then((value)
    {
      newsData = value?.data['articles'];
      emit(GetDataFormApiState());
    });
  }

  // this related to get data Search Data Api using Dio package
  List search = [];
  Future<void> getSearch({required String query}) async {
    search.clear();
    emit(GetSearchDataLoadingState());
    Response? response = await DioHelper.getNetworkData(methodUrl: 'v2/everything', query: {'q' : query,'apiKey' : '5dc516f347c946aa8b406da2764c066d',});
    if( response?.statusCode == 200 )
      {
        search = response!.data['articles'];
        emit(GetSearchDataSuccessState());
      }
    else
      {
        debugPrint("Error during get search Data ........");
        emit(GetSearchDataErrorState());
      }
  }

  void clearSearchData(){
    search.clear();
    emit(ClearSearchDataSuccessState());
  }

  // this related to Sqlite
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
  Future<void> InsertTODatabase({
    required String title,
    required String urlToImage,
    required String publishedAt,
  })
  async {
    await db?.transaction((txn) async {
      txn.rawInsert('INSERT INTO news(title,urlImage,publishedAt) VALUES ("${title}","${urlToImage}","${publishedAt}")');
    }).then((val)
    {
      emit(InsertToDatabaseState());
      print("Data was inserted to Database are => ${val}");
      getDatabase(db!);
    }).catchError((e) {
      debugPrint("Error during insert to Database, reason is $e");
    });
  }

  // 3. get Data form Database
  Future getDatabase(Database database)
  {
    return database.rawQuery("SELECT * FROM news").then((value)
    {
      archivedData = value;
      emit(GetDataFromDatabaseState());
    }).catchError((e)=>debugPrint("error during get data from database"));
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