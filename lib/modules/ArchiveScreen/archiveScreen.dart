import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/shared/component/constants.dart';
import 'package:news_app/shared/extensions_methods.dart';
import '../../layouts/cubit/layout_cubit.dart';
import '../../layouts/cubit/layout_states..dart';
import 'package:bloc/bloc.dart';
import '../../shared/component/component.dart';
import '../HomeScreen/home_cubit/homeStates.dart';
import '../HomeScreen/home_cubit/home_cubit.dart';
class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var data = HomeCubit.getInstance(context).archivedData;   // store data from database on variable data
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.all(10.0.h),
            child: data.isEmpty ?
            emptyDataItemView(context: context) :
            ListView.separated(
              itemCount: data.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 130.h,
                  padding: EdgeInsets.symmetric(horizontal: 15.0.h,vertical: 16.w),
                  decoration: BoxDecoration(
                      color: isDark? Colors.white.withOpacity(0.5) : Colors.black,
                      borderRadius: BorderRadius.circular(8.h)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            image: DecorationImage(image: NetworkImage(data[index]['urlImage']),fit: BoxFit.fill)
                        ),
                      ),
                      SizedBox(width: 20.w,),
                      Expanded(
                        child: Container(
                          height: 120.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text(data[index]['title'],overflow:TextOverflow.ellipsis,maxLines: 3,textDirection: arabicDirection,style: Theme.of(context).textTheme.titleMedium)),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(Jiffy(data[index]['publishedAt']).yMMMd,style: Theme.of(context).textTheme.labelMedium,),
                                  InkWell(
                                      child: Icon(Icons.delete,size: 20.h,color: isDark? Colors.black.withOpacity(0.6) : Colors.grey,),
                                      onTap: ()
                                      {
                                        HomeCubit.getInstance(context).DeleteDatebase(id: data[0]['id']);
                                      }
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
              separatorBuilder: (BuildContext context, int index) { return Container(height: 12.5.h);},
            ),
          )
        );
      },
    );
  }
}
