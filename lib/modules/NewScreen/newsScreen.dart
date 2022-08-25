import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layouts/cubit/cubit.dart';
import '../../layouts/cubit/states.dart';
import '../../shared/component/component.dart';
import '../details_screen/details_screen.dart';
class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var _cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
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
                _cubit.mydata.isEmpty? Container() :   // if data is empty will show empty container
                Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,i){
                        return GestureDetector(
                          onTap: (){
                           if(_cubit.mydata[i]['title'] == null || _cubit.mydata[i]['urlToImage'] == null || _cubit.mydata[i]['author'] == null || _cubit.mydata[i]['content'] == null)
                             {}
                           else
                           {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                 DetailsScreen(_cubit.mydata[i]['urlToImage'],_cubit.mydata[i]['title'],_cubit.mydata[i]['source']['name'],_cubit.mydata[i]['description'])));
                           }
                          },
                          child: Container(
                            height: 125,
                            child: BuildArticleItem(article: _cubit.mydata[i],context: context, isArchived: false),
                          ),
                        );
                      },
                      separatorBuilder: (context,i)=>Container(height: 25,),
                      itemCount: _cubit.mydata.length,
                    ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
