import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/shared/extensions_methods.dart';
import '../../shared/component/constants.dart';
import '../../shared/component/skeleton_news_component.dart';
import '../HomeScreen/home_cubit/homeStates.dart';
import '../HomeScreen/home_cubit/home_cubit.dart';
import '../details_screen/details_screen.dart';
class SearchScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.getInstance(context);
    return Scaffold(
        appBar: AppBar(leading: const SizedBox(),toolbarHeight: 25,backgroundColor: Colors.transparent,elevation: 0,),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16.sp),
                  controller: controller,
                  onFieldSubmitted: (input)
                  {
                    cubit.getSearch(query: input);
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: isDark? Colors.grey.withOpacity(0.4) : Colors.black.withOpacity(0.04),
                      suffixIcon: StatefulBuilder(
                        builder: (context,setState){
                          return GestureDetector(
                            child: Icon(Icons.clear,color: isDark? Colors.white : Colors.black,),
                            onTap: ()
                            {
                              setState(()
                              {
                                cubit.clearSearchData();
                                controller.text = "";
                              });
                            },
                          );
                        },
                      ),
                      label: Text("type_your_Search".translate(context: context),style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 15.sp,color: Colors.grey),),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4),borderSide: BorderSide(color: Colors.white))
                  ),
                ),
                SizedBox(height: 20.h,),
                Expanded(
                  child: BlocConsumer<HomeCubit,HomeStates>(
                    listener: (context,state) {},
                    builder: (context,state){
                      return state is GetSearchDataLoadingState ?
                          const SkeletonNewsComponent(usedInHomeScreen: false,) :
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: cubit.search.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: ()
                                {
                                  if(cubit.search[index]['urlToImage'] != null)
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {return DetailsScreen(cubit.search[index]['title'], cubit.search[index]['urlToImage'], cubit.search[index]['description']);}));
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15.w),
                                  decoration: BoxDecoration(color: isDark? Colors.white.withOpacity(0.5) : Colors.black,borderRadius: BorderRadius.circular(8.w)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 110.h,
                                        width: 110.w,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
                                        child: cubit.search[index]['urlToImage'] == null ? const Center(child: CircularProgressIndicator(color: Colors.white,),) :
                                        Image.network(cubit.search[index]['urlToImage'],fit: BoxFit.fill,width: 120.w,height: 120.h),
                                      ),
                                      SizedBox(width: 20.w,),
                                      Expanded(
                                        child: SizedBox(
                                          height: 110.h,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(child: Text(cubit.search[index]['title'],textDirection:arabicDirection,overflow:TextOverflow.ellipsis,maxLines: 3,
                                                  style: Theme.of(context).textTheme.titleMedium)),
                                              Text(Jiffy(cubit.search[index]['publishedAt']).yMMMd,style: Theme.of(context).textTheme.labelMedium),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) { return Container(height: 18.h);},
                          );
                    },
                  )
                )
              ],
            ),
          ),
        )
    );
  }
}
