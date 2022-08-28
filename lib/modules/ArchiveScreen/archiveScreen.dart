import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/shared/component/constants.dart';
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
        var data = AppCubit.get(context).archivedData;   // store data from database on variable data
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.all(10.0),
            child: data.isEmpty? const Center(child: Text("Archived Data haven't been added yet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),) :
            ListView.separated(
              itemCount: data.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 130,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: NetworkImage(data[index]['urlImage']),fit: BoxFit.fill)
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                          height: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text(data[index]['title'],overflow:TextOverflow.ellipsis,maxLines: 3,textDirection: arabicDirection,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white))),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(Jiffy(data[index]['publishedAt']).yMMMd,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13,color: Colors.grey),),
                                  Container(
                                    margin:const EdgeInsets.only(right: 5),
                                    child: InkWell(
                                        child: const Icon(Icons.delete,size: 20,color: Colors.grey,),
                                        onTap: (){
                                          AppCubit.get(context).DeleteDatebase(id: data[0]['id']);
                                        }
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) { return Container(height: 10);},
            ),
          )
        );
      },
    );
  }
}
