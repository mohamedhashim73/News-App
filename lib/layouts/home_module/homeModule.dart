import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
class HomeModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var _cubit = AppCubit.get(context);
          var _newsData = _cubit.mydata;
          List menu = ['Country','Category'];
          return Scaffold(
          appBar: AppBar(
              title: Text(_cubit.titleScreen[_cubit.initialIndex]),
              actions: [
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
                          position: const RelativeRect.fromLTRB(
                              25.0, 25.0, 0.0, 0.0),
                          items: const [
                            PopupMenuItem<String>(
                                value: '1',
                                child: Text('Egypt')),
                            PopupMenuItem<String>(
                                value: '2',
                                child: Text('United States')),
                            PopupMenuItem<String>(
                                value: '3',
                                child: Text('Arminia')),
                            PopupMenuItem<String>(
                                value: '4',
                                child: Text('Belgium')),
                          ],
                          elevation: 0,
                        ).then((value) {
                          if(value == '1')
                          {
                            _cubit.changeSelectedCountry('eg');
                            _cubit.getData();
                          } else if(value == '2')
                          {
                            _cubit.changeSelectedCountry('us');
                            _cubit.getData();
                          } else if(value == '3')
                          {
                            _cubit.changeSelectedCountry('ar');
                            _cubit.getData();
                          }
                          else if(value == '4')
                          {
                            _cubit.changeSelectedCountry('bg');
                            _cubit.getData();
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
                              _cubit.changeSelectedCountry('general');
                              _cubit.getData();
                            } else if(value == '2')
                            {
                              _cubit.changeSelectedCountry('sports');
                              _cubit.getData();
                            } else if(value == '3')
                            {
                              _cubit.chooseCategory('science');
                              _cubit.getData();
                            }
                            else if(value == '4')
                            {
                              _cubit.chooseCategory('health');
                              _cubit.getData();
                            }
                          });
                        }
                  },
                )
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
