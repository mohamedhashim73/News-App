import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/SearchScreen/search.dart';
import '../../shared/component/constants.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
class HomeModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var _cubit = AppCubit.get(context);
          List menu = ['Country','Category'];
          return Scaffold(
          appBar: AppBar(
              title: Text(_cubit.titleScreen[_cubit.initialIndex]),
              actions: [
                InkWell(child: const Icon(Icons.search),onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                },),
                PopupMenuButton(
                    itemBuilder: (context){
                      return menu.map((item) {
                        return PopupMenuItem(
                          child: Text(item),
                          value: item,
                        );
                      }).toList();},
                  onSelected: (selectedItem){
                      if(selectedItem == 'Country') {
                        showMenu(
                          context: context,
                          position: const RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),
                          items: const [
                            PopupMenuItem<String>(
                                value: '1',
                                child: Text('Egypt')),
                            PopupMenuItem<String>(
                                value: '2',
                                child: Text('United States')),
                            PopupMenuItem<String>(
                                value: '3',
                                child: Text('Germany')),
                            PopupMenuItem<String>(
                                value: '4',
                                child: Text('France')),
                          ],
                          elevation: 0,
                        ).then((value) {
                          if(value == '1')
                          {
                            _cubit.selectCountry('eg');
                            arabicDirection = TextDirection.rtl;
                            _cubit.getNews(country: 'eg', category: _cubit.category);
                          } else if(value == '2')
                          {
                            _cubit.selectCountry('us');
                            arabicDirection = TextDirection.ltr;
                            _cubit.getNews(country: 'us', category: _cubit.category);
                          } else if(value == '3')
                          {
                            _cubit.selectCountry('de');
                            arabicDirection = TextDirection.ltr;
                            _cubit.getNews(country: 'de', category: _cubit.category);
                          }
                          else if(value == '4')
                          {
                            _cubit.selectCountry('fr');
                            arabicDirection = TextDirection.ltr;
                            _cubit.getNews(country: 'fr', category: _cubit.category);
                          }
                        });
                      }
                      else if(selectedItem == 'Category')
                        {
                          showMenu(
                            context: context,
                            position: const RelativeRect.fromLTRB(
                                25.0, 25.0, 0.0, 0.0),
                            items: const [
                              PopupMenuItem<String>(
                                  value: '1',
                                  child: Text('General')),
                              PopupMenuItem<String>(
                                  value: '2',
                                  child: Text('Sports')),
                              PopupMenuItem<String>(
                                  value: '3',
                                  child: Text('Science')),
                              PopupMenuItem<String>(
                                  value: '4',
                                  child: Text('Health')),
                            ],
                            elevation: 0,
                          ).then((value) {
                            if(value == '1')
                            {
                              _cubit.selectCategory('general');
                              _cubit.getNews(country: _cubit.country, category: 'general');
                            } else if(value == '2')
                            {
                              _cubit.selectCategory('sports');
                              _cubit.getNews(country: _cubit.country, category: 'sports');
                            } else if(value == '3')
                            {
                              _cubit.selectCategory('science');
                              _cubit.getNews(country: _cubit.country, category: 'science');
                            }
                            else if(value == '4')
                            {
                              _cubit.selectCategory('health');
                              _cubit.getNews(country: _cubit.country, category: 'health');
                            }
                          });
                        }
                  },
                ),
              ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.black),
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(12),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.orange.shade900,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.archive),label: "Archive"),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
              ],
              onTap: (index){
                _cubit.ChangeBottomNavIndex(index);
              },
              currentIndex: _cubit.initialIndex,
            ),
          ),
          body: _cubit.screens[_cubit.initialIndex],
          );
        },
    );
  }
}
