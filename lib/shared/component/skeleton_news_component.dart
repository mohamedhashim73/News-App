import 'package:flutter/material.dart';
import 'component.dart';

class SkeletonNewsComponent extends StatelessWidget {
  final bool usedInHomeScreen ;    // Todo: as if it used in HomeScreen I will disabled scroll else it will be enabled
  const SkeletonNewsComponent({Key? key,required this.usedInHomeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: usedInHomeScreen == true ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context,index) => _skeletonComponent(),
      itemCount: 10,
    );
  }

  // Todo: for one Item from News
  Widget _skeletonComponent(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Todo: Image
          const SkeletonItem(
            height: 110,
            width: 110,
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: SizedBox(
              height: 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: SkeletonItem()),
                  const SizedBox(height: 12.5,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const
                    [
                      Expanded(child: SkeletonItem(height: 20,)),
                      SizedBox(width: 10,),
                      SkeletonItem(height: 20,width: 35,)
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
}


