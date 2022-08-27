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
                            child: InkWell(
                              child: Text(item),
                              onTap: (){
                                if(item=='Category')
                                {
                                  // showMenu(context: context, position: position, items: items)
                                }
                                else
                                {
                                  
                                }
                              },
                            ));
                      }).toList();},
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
