import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/layouts/cubit/cubit.dart';
import 'package:news_app/layouts/cubit/states.dart';

import '../../shared/component/component.dart';
import '../../shared/component/constants.dart';
import '../details_screen/details_screen.dart';
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = AppCubit.get(context);
          var mySearch = cubit.search;
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: (val){ return searchController.text.isEmpty ? "Search must not be empty" : null ;},
                    onChanged: (val){
                      cubit.getSearchData(query: val);
                      print(cubit.search);
                    },
                    decoration: InputDecoration(
                      label: const Text("type your search"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))
                    ),
                  ),
                  SizedBox(height: 10,),
                  state is LoadingDuringGettingDataFromApi ? Text('') :
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: mySearch.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: ()
                          {
                            if(mySearch[index]['urlToImage'] != null)
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {return DetailsScreen(mySearch[index]['title'], mySearch[index]['urlToImage'], mySearch[index]['description']);}));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 110,
                                  width: 110,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  child: mySearch[index]['urlToImage'] == null ? const Center(child: CircularProgressIndicator(color: Colors.white,),) :
                                  Image.network(mySearch[index]['urlToImage'],fit: BoxFit.fill,width: 120,height: 120),
                                ),
                                const SizedBox(width: 20,),
                                Expanded(
                                  child: SizedBox(
                                    height: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: Text(mySearch[index]['title'],textDirection:arabicDirection,overflow:TextOverflow.ellipsis,maxLines: 3,
                                            style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16.5,color: Colors.white))),
                                        Text(Jiffy(mySearch[index]['publishedAt']).yMMMd,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13,color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) { return Container(height: 10);},
                    ),
                  )
                ],
              )
            )
          );
        },
    );
  }
}
