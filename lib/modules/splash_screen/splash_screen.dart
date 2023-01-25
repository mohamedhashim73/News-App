import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/layouts/layout_screen/layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 6)).then((value)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              Image.asset("assets/images/logo.png",fit: BoxFit.contain,height: 125.h,width: 125.w,),
              SizedBox(height: 16.h,),
              DefaultTextStyle(
                style: TextStyle(color: Colors.orange.shade900,fontSize: 20.sp,fontWeight: FontWeight.w600,),
                child: AnimatedTextKit(
                  animatedTexts:
                  [
                    WavyAnimatedText('News App'),
                  ],
                  isRepeatingAnimation: true,
                  onTap: ()
                  {
                    print("Tap Event");
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}
