import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import '../../layouts/cubit/cubit.dart';
import '../../layouts/cubit/states.dart';
import '../../shared/component/component.dart';
import '../details_screen/details_screen.dart';
class NewsScreen extends StatelessWidget {
  var pageViewController =  PageController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var _cubit = AppCubit.get(context);
        var _newsData = _cubit.mydata;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: double.infinity,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: (chosenCountry)
                              {
                                _cubit.changeSelectedCountry(chosenCountry.toString());
                                _cubit.getData();
                              },
                              value: _cubit.selectedCountry,
                              items: ["eg","us","ar","bg","ua"].map((e) => DropdownMenuItem(child: Text("Country $e",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),value: e,)).toList(),
                            ),
                          ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: ["sports","science","general","technology","health"].map((e) => DropdownMenuItem(child: Text("${e}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17)),value: e,)).toList(),
                            onChanged: (val)
                            {
                              _cubit.chooseCategory(val.toString());
                              _cubit.getData();
                            },
                            value: _cubit.selectedCategory,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text("Recent News",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21)),
                ),
                const SizedBox(height: 5),
                _cubit.mydata.isEmpty? Container() :   // if data is empty will show empty container
                Expanded(
                  child: ListView.separated(
                    itemCount: _newsData.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return DetailsScreen(_newsData[index]['title'], _newsData[index]['urlToImage'],_newsData[index]['description']);
                          }));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                child: _newsData[index]['urlToImage'] == null ? const Center(child: CircularProgressIndicator(color: Colors.white,),) :
                                Image.network(_newsData[index]['urlToImage'],fit: BoxFit.fill,width: 120,height: 120),
                              ),
                              const SizedBox(width: 20,),
                              Expanded(
                                child: SizedBox(
                                  height: 120,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: Text(_newsData[index]['title'],overflow:TextOverflow.ellipsis,maxLines: 3,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white))),
                                      InkWell(
                                        onTap: (){
                                          _cubit.InsertTODatabase
                                            (
                                            title: _newsData[index]['title'],
                                            urlToImage: _newsData[index]['urlToImage'],
                                            publishedAt: _newsData[index]['publishedAt'],
                                          );
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(Jiffy(_newsData[index]['publishedAt']).yMMMd,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13,color: Colors.grey),),
                                            const Icon(Icons.archive,size: 20,color: Colors.grey,)
                                          ],
                                        ),
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
                    separatorBuilder: (BuildContext context, int index) { return Container(height: 10);},
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
