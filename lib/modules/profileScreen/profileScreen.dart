import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/layouts/cubit/layout_cubit.dart';
import 'package:news_app/shared/component/constants.dart';
import 'package:news_app/shared/extensions_methods.dart';
import '../../layouts/cubit/layout_states..dart';
import '../../models/language_model.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          final cubit = LayoutCubit.getInstance(context);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0.h,horizontal: 15.w),
              child: Column(
                children:
                [
                  Container(
                      height: MediaQuery.of(context).size.height*0.25,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 60.h,
                        foregroundColor: isDark? Colors.white : Colors.black,
                        backgroundColor: isDark? Colors.grey.withOpacity(0.5) : Colors.black.withOpacity(0.2),
                        child: Icon(Icons.person,size: 60.h,),
                      )
                  ),
                  SizedBox(height: 10.h,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Container(
                            height: 58.h,
                            color: isDark? Colors.grey.withOpacity(0.5) : Colors.black.withOpacity(0.09),
                            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                            child: Row(
                              children:
                              [
                                Text("archive".translate(context: context),style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 17.sp,fontWeight: FontWeight.w600)),
                                const Spacer(),
                                Icon(Icons.archive,color: isDark? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.5),)
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Container(
                            height: 58.h,
                            color: isDark? Colors.grey.withOpacity(0.5) : Colors.black.withOpacity(0.09),
                            padding: EdgeInsets.symmetric(horizontal: 10).w,
                            child: Row(
                              children:
                              [
                                Text("change_theme".translate(context: context),style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 17.sp,fontWeight: FontWeight.w600)),
                                const Spacer(),
                                Switch(
                                    value: isDark,
                                    onChanged: (newValue)
                                    {
                                      cubit.changeAppTheme(newValue: newValue);
                                    }
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                              child: Text("change_language".translate(context: context),style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 17.sp,fontWeight: FontWeight.w600))),
                          SizedBox(height: 20.sp,),
                          Container(
                              height: 58.h,
                              color: isDark? Colors.grey.withOpacity(0.5) : Colors.black.withOpacity(0.09),
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  menuMaxHeight: 120.h,
                                  value: currentLocaleApp.languageCode,
                                  alignment: AlignmentDirectional.centerEnd,
                                  dropdownColor: isDark? Colors.grey : Colors.grey,
                                  elevation: 0,
                                  icon: Icon(Icons.arrow_drop_down,color: isDark? Colors.white : Colors.black.withOpacity(0.3),size: 30.h,),
                                  onChanged: (newValue)
                                  {
                                    cubit.changeAppLanguage(locale: Locale(newValue.toString()));
                                  },
                                  // Todo: made translate to language.langName to keep with the current locale
                                  items: languageOptions.map((language) => DropdownMenuItem(
                                    value: language.langIsoCode,
                                    child: Text(language.langName.translate(context: context),style: TextStyle(color: isDark? Colors.white : Colors.black),),
                                  )
                                  ).toList(),
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          );
        },
        );
  }
}
