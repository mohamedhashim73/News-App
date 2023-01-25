import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/cubit/layout_states..dart';
import 'package:news_app/modules/SearchScreen/search.dart';
import 'package:news_app/shared/extensions_methods.dart';
import '../../modules/HomeScreen/home_cubit/home_cubit.dart';
import '../../shared/component/constants.dart';
import '../cubit/layout_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.getInstance(context);
    List menu = ['country'.translate(context: context),'category'.translate(context: context)];
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
          appBar: AppBar(
              title: Text("news".translate(context: context)),    // Todo: used an extension to get the value
              backgroundColor: Colors.transparent,
              actions: [
                InkWell(child: const Icon(Icons.search),onTap: ()
                {
                  HomeCubit.getInstance(context).search.clear();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                },
                ),
                PopupMenuButton(
                    itemBuilder: (context){
                      return menu.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item,style: TextStyle(color: Colors.black)),
                        );
                      }).toList();},
                  onSelected: (selectedItem){
                      if(selectedItem == 'country'.translate(context: context)) {
                        showMenu(
                          context: context,
                          position: currentLocaleApp.languageCode == "en" || currentLocaleApp.languageCode == "fr" ? const RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0) : const RelativeRect.fromLTRB(0.0, 0.0, 25.0, 25.0),
                          items: [
                            PopupMenuItem<String>(
                                value: '1',
                                child: Text('egypt'.translate(context: context),style: TextStyle(color: Colors.black),)),
                            PopupMenuItem<String>(
                                value: '2',
                                child: Text('united_states'.translate(context: context),style: TextStyle(color: Colors.black))),
                            PopupMenuItem<String>(
                                value: '3',
                                child: Text('germany'.translate(context: context),style: TextStyle(color: Colors.black))),
                            PopupMenuItem<String>(
                                value: '4',
                                child: Text('france'.translate(context: context),style: TextStyle(color: Colors.black))),
                          ],
                          elevation: 0,
                        ).then((value) {
                          if(value == '1')
                          {
                            cubit.selectCountry('eg');
                            arabicDirection = TextDirection.rtl;
                            HomeCubit.getInstance(context).getNews(country: 'eg', category: cubit.category);
                          } else if(value == '2')
                          {
                            cubit.selectCountry('us');
                            arabicDirection = TextDirection.ltr;
                            HomeCubit.getInstance(context).getNews(country: 'us', category: cubit.category);
                          } else if(value == '3')
                          {
                            cubit.selectCountry('de');
                            arabicDirection = TextDirection.ltr;
                            HomeCubit.getInstance(context).getNews(country: 'de', category: cubit.category);
                          }
                          else if(value == '4')
                          {
                            cubit.selectCountry('fr');
                            arabicDirection = TextDirection.ltr;
                            HomeCubit.getInstance(context).getNews(country: 'fr', category: cubit.category);
                          }
                        });
                      }
                      else if(selectedItem == 'category'.translate(context: context))
                        {
                          showMenu(
                            context: context,
                            position: currentLocaleApp.languageCode == "en" || currentLocaleApp.languageCode == "fr" ? const RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0) : const RelativeRect.fromLTRB(0.0, 0.0, 25.0, 25.0),
                            items: [
                              PopupMenuItem<String>(
                                  value: '1',
                                  child: Text('general'.translate(context: context),style: TextStyle(color: Colors.black))),
                              PopupMenuItem<String>(
                                  value: '2',
                                  child: Text('sports'.translate(context: context),style: TextStyle(color: Colors.black))),
                              PopupMenuItem<String>(
                                  value: '3',
                                  child: Text('science'.translate(context: context),style: TextStyle(color: Colors.black))),
                              PopupMenuItem<String>(
                                  value: '4',
                                  child: Text('health'.translate(context: context),style: TextStyle(color: Colors.black))),
                            ],
                            elevation: 0,
                          ).then((value) {
                            if(value == '1')
                            {
                              cubit.selectCategory('general');
                              HomeCubit.getInstance(context).getNews(country: cubit.country, category: 'general');
                            } else if(value == '2')
                            {
                              cubit.selectCategory('sports');
                              HomeCubit.getInstance(context).getNews(country: cubit.country, category: 'sports');
                            } else if(value == '3')
                            {
                              cubit.selectCategory('science');
                              HomeCubit.getInstance(context).getNews(country: cubit.country, category: 'science');
                            }
                            else if(value == '4')
                            {
                              cubit.selectCategory('health');
                              HomeCubit.getInstance(context).getNews(country: cubit.country, category: 'health');
                            }
                          });
                        }
                  },
                ),
              ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: isDark? Colors.white : Colors.black),
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(12),
            child: BottomNavigationBar(
              items:
              [
                BottomNavigationBarItem(icon: const Icon(Icons.home),label: "home".translate(context: context)),
                BottomNavigationBarItem(icon: const Icon(Icons.archive),label: "archive".translate(context: context)),
                BottomNavigationBarItem(icon: const Icon(Icons.person),label: "profile".translate(context: context)),
              ],
              onTap: (index){
                cubit.changeBottomNavIndex(index);
              },
              currentIndex: cubit.currentIndexForBottomNav,
            ),
          ),
          body: cubit.screens[cubit.currentIndexForBottomNav],
          );
        },
    );
  }
}
