import 'package:flutter/material.dart';
class DetailsScreen extends StatelessWidget {
  final String title;
  final String urlImage;
  final String content;
  final String source;
  DetailsScreen(this.urlImage,this.title,this.source,this.content);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details"),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(title,maxLines:3,overflow:TextOverflow.visible,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
            SizedBox(height: 10,),
            Row(
              children:
              [
                const Text("source : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300)),
                Text(source,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w300)),
              ],
            ),
            Container(
              height: 220,
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),image: DecorationImage(image: NetworkImage(urlImage),fit: BoxFit.fill)),
            ),
            SizedBox(height: 10,),
            Expanded(child: Text(content,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))),
          ],
        ),
      )
    );
  }
}
