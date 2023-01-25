import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/shared/extensions_methods.dart';
import 'constants.dart';

Widget defaultTextFormField ({
  required TextEditingController controller,
  required TextInputType type,
  Text? label,
  required Function validatorFunction,
}) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    validator: validatorFunction(),
    decoration: InputDecoration(
      label: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    ),
  );
}

class SkeletonItem extends StatelessWidget{
  final double? height;
  final double? width;
  final Color? color;
  const SkeletonItem({super.key,this.height,this.width,this.color});

  @override
  Widget build(BuildContext context){
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: color == null ? isDark? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.04) : color,
          borderRadius: BorderRadius.circular(16)
      ),
    );
  }
}

// Todo: This widget will be shown when there is no data on Archived screen
Widget emptyDataItemView({required BuildContext context}){
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 15.0.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
      [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              SvgPicture.asset('assets/images/empty_box.svg',color: Colors.grey,height: 125.h,width: 125.w,),
              SizedBox(height: 15.h,),
              Center(
                child: Text("noDataOnArchive".translate(context: context),style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18.5.sp,fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}