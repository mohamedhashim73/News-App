import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import '../../layouts/cubit/cubit.dart';
import '../../layouts/cubit/states.dart';
import '../details_screen/details_screen.dart';
class NewsScreen extends StatelessWidget {
  var pageViewController =  PageController();
  NewsScreen({Key? key}) : super(key: key);
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
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _newsData.isEmpty? Center(child: Text("loading"),) :
            ListView(
              physics: BouncingScrollPhysics(),
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
                            items: ["sports","science","general","technology","health"].
                            map((e) => DropdownMenuItem(child: Text("${e}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17)),value: e,)).toList(),
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
                  child: Text("Breaking News",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21)),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: 180,
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
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return DetailsScreen(_newsData[i]['title'], _newsData[i]['urlToImage'],_newsData[i]['description']);
                            }));
                          },
                          child: Container(
                            width: 300,
                            height: 160,
                            clipBehavior: Clip.hardEdge,
                            margin: const EdgeInsets.only(right: 25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: _newsData == null? DecorationImage(image: NetworkImage(_newsData[i]['urlToImage']),fit: BoxFit.fill) : null,
                            ),
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 70),
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [Colors.transparent,Colors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter,)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(child: Text(_newsData[i]['title'],overflow:TextOverflow.ellipsis,maxLines: 2,
                                      style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.white))),
                                  SizedBox(height:20,child: Text(_newsData[i]['source']['name'],style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14,color: Colors.grey),)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text("Recent News",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21)),
                ),
                const SizedBox(height: 5),
                _cubit.mydata.isEmpty? Container() :   // if data is empty will show empty container
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: _newsData.length,
                  physics: const NeverScrollableScrollPhysics(),
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
                              height: 110,
                              width: 110,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                              child: _newsData[index]['urlToImage'] == null ? const Center(child: CircularProgressIndicator(color: Colors.white,),) :
                              Image.network(_newsData[index]['urlToImage'],fit: BoxFit.fill,width: 120,height: 120),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                              child: SizedBox(
                                height: 110,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: Text(_newsData[index]['title'],overflow:TextOverflow.ellipsis,maxLines: 3,
                                        style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16.5,color: Colors.white))),
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
