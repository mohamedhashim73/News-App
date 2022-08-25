import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/layouts/cubit/cubit.dart';
Widget BuildArticleItem({required Map article,required BuildContext context,required bool isArchived}){
  return Container(
    height: isArchived == false ? 160 : 130,
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(20)
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(article['urlToImage'] ?? "https://cdn.cnn.com/cnnnext/dam/assets/220819153438-mar-a-lago-file-081022-super-tease.jpg"),
                  fit: BoxFit.fill)
          ),
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Container(
            width: 130,
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text("${article['title']}",overflow:TextOverflow.ellipsis,maxLines: 3,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white))),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Jiffy(article['publishedAt']).yMMMd,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13,color: Colors.grey),),
                    Container(
                      margin:const EdgeInsets.only(right: 5),
                      child: isArchived == false ?
                      InkWell(child: Icon(Icons.archive,size: 20,color: Colors.grey,),onTap: (){
                        AppCubit.get(context).InsertData
                          (
                            title: article['title'],
                            urlToImage: article['urlToImage'],
                            publishedAt: article['publishedAt'],
                            url: article['url'],
                            content: article['description']
                        );
                      }) :
                      // natural page for displaying news
                      InkWell(child: Icon(Icons.delete,size: 20,color: Colors.grey,),onTap: (){
                        AppCubit.get(context).DeleteDatebase(id: article['id']);
                      }),
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
}