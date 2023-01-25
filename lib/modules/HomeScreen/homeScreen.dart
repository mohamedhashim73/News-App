import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/shared/component/constants.dart';
import 'package:news_app/shared/component/skeleton_news_component.dart';
import 'package:news_app/shared/extensions_methods.dart';
import '../../shared/component/component.dart';
import '../details_screen/details_screen.dart';
import 'home_cubit/homeStates.dart';
import 'home_cubit/home_cubit.dart';

class NewsScreen extends StatelessWidget {
  final PageController pageViewController =  PageController();
  NewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeCubit.getInstance(context);
        var breakingNewsData = cubit.newsData.length-3;   // to get the last 3 news from each category to display on breaking news
        return Scaffold(
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
              final bool connectedWIthNetwork = connectivity != ConnectivityResult.none;   // Todo: store true if the device connected with network throw Wifi or Mobile Data
              if( connectedWIthNetwork )
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: cubit.newsData.isEmpty ?
                  _skeletonComponentView() :
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("breakingNews".translate(context: context),style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 21.5.sp,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7.h),
                        height: 170.h,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context,i)
                            {
                              return InkWell(
                                onTap: ()
                                {
                                  if(cubit.newsData[breakingNewsData-i]['urlToImage'] != null)
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return DetailsScreen(cubit.newsData[breakingNewsData-i]['title'], cubit.newsData[breakingNewsData-i]['urlToImage'],cubit.newsData[breakingNewsData-i]['description']);
                                    }));
                                  }
                                },
                                child: Container(
                                  width: 300.w,
                                  height: 160.h,
                                  clipBehavior: Clip.hardEdge,
                                  margin: EdgeInsets.only(right: currentLocaleApp.languageCode == "en" ? 25.w : 0 , left: currentLocaleApp.languageCode == "en" ? 0 : 25.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.5.h),
                                    image: cubit.newsData[breakingNewsData-i]['urlToImage'] != null ?
                                    DecorationImage(image: NetworkImage(cubit.newsData[breakingNewsData-i]['urlToImage']),fit: BoxFit.fill) : null ,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    alignment: AlignmentDirectional.bottomStart,
                                    padding: EdgeInsets.symmetric(horizontal: 12.5.w,vertical: 20.h),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors:
                                          [
                                            cubit.newsData[breakingNewsData-i]['urlToImage'] != null ? Colors.transparent : Colors.blueGrey.withOpacity(0.5),
                                            isDark? Colors.white : Colors.black,
                                          ],
                                          begin: Alignment.topCenter, end: Alignment.bottomCenter,
                                        )
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(cubit.newsData[breakingNewsData-i]['title'],
                                          textDirection: arabicDirection,
                                          maxLines: 2,
                                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18.5.sp,fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0.w),
                        child: Text("recentNews".translate(context: context),style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 21.5.sp,fontWeight: FontWeight.bold),),
                      ),
                      // Todo: All news will be shown here
                      SizedBox(height: 7.h),
                      cubit.newsData.isEmpty? Container() :   // if data is empty will show empty container
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: cubit.newsData.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: ()
                            {
                              if(cubit.newsData[index]['urlToImage'] != null)
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {return DetailsScreen(cubit.newsData[index]['title'], cubit.newsData[index]['urlToImage'], cubit.newsData[index]['description']);}));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(17.w),
                              decoration: BoxDecoration(color: isDark? Colors.white.withOpacity(0.5) : Colors.black,borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 110.h,
                                    width: 110.w,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
                                    child: cubit.newsData[index]['urlToImage'] == null ? SkeletonItem(color: Colors.grey.withOpacity(0.4),) :
                                    Image.network(cubit.newsData[index]['urlToImage'],fit: BoxFit.fill,width: 110.w,height: 110.h),
                                  ),
                                  const SizedBox(width: 20,),
                                  Expanded(
                                    child: SizedBox(
                                      height: 110.h,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(child: Text(cubit.newsData[index]['title'],overflow:TextOverflow.ellipsis,maxLines: 3,
                                            textDirection: arabicDirection,
                                            style: Theme.of(context).textTheme.titleMedium,)
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(Jiffy(cubit.newsData[index]['publishedAt']).yMMMd,style: Theme.of(context).textTheme.labelMedium),
                                              InkWell(
                                                  onTap: ()
                                                  {
                                                    if( cubit.newsData[index]['urlToImage'] != null )
                                                      {
                                                        cubit.InsertTODatabase(title: cubit.newsData[index]['title'],urlToImage: cubit.newsData[index]['urlToImage'],
                                                          publishedAt: cubit.newsData[index]['publishedAt'],).then((value){
                                                            ScaffoldMessenger.of(context).
                                                            showSnackBar(
                                                                SnackBar(
                                                                  content: Text("added_successfully".translate(context: context),style: TextStyle(color: Colors.white,fontSize: 17.sp),),
                                                                  duration: Duration(seconds: 1),
                                                                  backgroundColor: Colors.green,
                                                                )
                                                            );
                                                        });
                                                      }
                                                    else
                                                    {
                                                      ScaffoldMessenger.of(context).
                                                      showSnackBar(
                                                          SnackBar(
                                                            content: Text("item_can't_be_added".translate(context: context),style: TextStyle(color: Colors.white,fontSize: 17.sp),),
                                                            duration: Duration(seconds: 1),
                                                            backgroundColor: Colors.red,
                                                          )
                                                      );
                                                    }
                                                  },
                                                  child: Icon(Icons.archive,size: 20.w,color: isDark? Colors.black.withOpacity(0.6) : Colors.grey,)
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) { return Container(height: 15.h);},
                      )
                    ],
                  ),
                );
              else
                return _widthOutNetworkView();
            },
            child: Text(""),
          )
        );
      },
    );
  }

  Widget _skeletonComponentView(){
    return ListView(
      physics: const BouncingScrollPhysics(),
      children:
      [
        SizedBox(height: 10.h,),
        Align(alignment:AlignmentDirectional.topStart,child: SkeletonItem(width: 120.w,height: 30.h,)),
        SizedBox(height: 12.h,),
        Container(margin: EdgeInsets.symmetric(horizontal: 0),child: SkeletonItem(width: double.infinity,height: 120.h,)),
        SizedBox(height: 12.h,),
        Align(alignment:AlignmentDirectional.topStart,child: SkeletonItem(width: 130.w,height: 30.h,)),
        SizedBox(height: 8.h,),
        SkeletonNewsComponent(usedInHomeScreen: true),
      ],
    );
  }

  Widget _widthOutNetworkView(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          Image.asset("assets/images/without-internet.png",fit: BoxFit.contain,height: 125.h,width: 125.w,),
          SizedBox(height: 10.h,),
          DefaultTextStyle(
            style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.w500),
            child: Text("Check Internet and try again ☺",style: TextStyle(color: isDark? Colors.grey : Colors.black.withOpacity(0.8)),)
          ),
        ],
      ),
    );
  }
}
