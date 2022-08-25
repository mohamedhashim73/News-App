import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layouts/cubit/cubit.dart';
import '../../layouts/cubit/states.dart';
import 'package:bloc/bloc.dart';
import '../../shared/component/component.dart';
class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var _cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            margin: const EdgeInsets.all(12.0),
            height: double.infinity,
            width: double.infinity,
            child: _cubit.archivedData.isEmpty? const Center(child: Text("No Archived News have been added"),):
            ListView.separated(
                itemBuilder: (context,i) => BuildArticleItem(article: _cubit.archivedData[i],context: context, isArchived: true),  // archived
                separatorBuilder: (context,i)=>Container(height: 20,),
                itemCount: _cubit.archivedData.length
            ),
          )
        );
      },
    );
  }
}
