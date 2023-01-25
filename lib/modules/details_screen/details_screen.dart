import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/shared/component/constants.dart';
import 'package:news_app/shared/extensions_methods.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String urlToImage;
  final String description;
  DetailsScreen(this.title, this.urlToImage, this.description);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("details".translate(context: context))),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.all(15.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  textDirection: arabicDirection,
                  maxLines: 3,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: isDark? Colors.white : Colors.black)),
              Container(
                height: 220,
                margin: EdgeInsets.symmetric(vertical: 25.h),
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(0)),
                child: urlToImage == null
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Image.network(urlToImage,
                        fit: BoxFit.fill, width: double.infinity, height: 120.h),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                  child: Text(description,
                      textDirection: arabicDirection,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: isDark? Colors.white : Colors.black,fontSize: 18.sp))
              ),
            ],
          ),
        ));
  }
}
