import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:flutter/cupertino.dart';

class AddScreenWidget {

  Widget buildSliderSection({required BuildContext context, required List<String> images}) {
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
                items: List.generate(images.length, (index) => _buildSliderImage(context: context, imageUrl: images[index])),
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enableInfiniteScroll: images.length>1?true:false,
                  viewportFraction: images.length>1?0.69:1,
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

  Widget _buildSliderImage({required BuildContext context,required String imageUrl}){
    return imageUrl.isNotEmpty?ClipRRect(borderRadius: BorderRadius.circular(8.0),child: CachedNetworkImage(imageUrl: imageUrl,height: 180,fit: BoxFit.cover,placeholder:(context,url)=> Container(color: AppColors.grey2,),errorWidget: (context,url,error)=>Container(color: AppColors.grey2,),)):Container(color: AppColors.grey2,);
  }
}