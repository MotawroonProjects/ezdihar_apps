import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:flutter/cupertino.dart';

class AddScreenWidget {

  Widget buildSliderSection({required BuildContext context, required List<Object> images}) {
    var items = [
      AddScreenWidget()._buildSliderImage(context: context, object: Object()),
      AddScreenWidget()._buildSliderImage(context: context, object: Object()),
      AddScreenWidget()._buildSliderImage(context: context, object: Object()),
      AddScreenWidget()._buildSliderImage(context: context, object: Object()),
      AddScreenWidget()._buildSliderImage(context: context, object: Object())
    ];
    return Container(
      margin: const EdgeInsets.only(top: 60.0),
      color: AppColors.grey3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(color: AppColors.grey4,height: 1.0,),
          Container(
            color: AppColors.grey3,
            padding: const EdgeInsets.only(top: 8.0),
            child: CarouselSlider(
                items: items,
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  viewportFraction: .69,
                  scrollDirection: Axis.horizontal,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  initialPage: 0,
                  autoPlayInterval: const Duration(seconds: 4),
                  enlargeCenterPage: true,
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderImage({required BuildContext context,required Object object}){
    return Image.asset('${AppConstant.localImagePath}test.png',fit: BoxFit.cover,);
  }
}