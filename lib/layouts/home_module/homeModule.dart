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
          return Scaffold(
          appBar: AppBar(title: Text("${_cubit.titleScreen[_cubit.initialIndex]}"),),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.transparent),
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(15),
            child: BottomNavigationBar(
              backgroundColor: Colors.black,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.archive),label: "Archive"),
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
