import 'package:flutter/material.dart';
import 'package:news_app/shared/component/constants.dart';
class DetailsScreen extends StatelessWidget {
  final String title;
  final String urlToImage;
  final String description;
  DetailsScreen(this.title,this.urlToImage,this.description);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(title,textDirection:arabicDirection,maxLines:3,overflow:TextOverflow.visible,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
            Container(
              height: 220,
              margin: const EdgeInsets.symmetric(vertical: 25),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: urlToImage == null ? const Center(child: CircularProgressIndicator(color: Colors.white,),) :
              Image.network(urlToImage,fit: BoxFit.fill,width: double.infinity,height: 120),
             ),
            SizedBox(height: 10,),
            Expanded(child: Text(description,textDirection:arabicDirection,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))),
          ],
        ),
      )
    );
  }
}
