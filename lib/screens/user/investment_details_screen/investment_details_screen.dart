import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/user/investment_details_screen/widgets/investment_details_widgets.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class InvestmentDetailsPage extends StatefulWidget {
  const InvestmentDetailsPage({Key? key}) : super(key: key);

  @override
  State<InvestmentDetailsPage> createState() => _InvestmentDetailsPageState();
}

class _InvestmentDetailsPageState extends State<InvestmentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey3,
      body: _buildBodySection());
  }

  Widget _buildBodySection() {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(child:
        ListView(
          children: [
            _buildHeaderSection(context: context),
            _buildDetailsSection(context: context),
            _buildReportSection(context: context)
          ],
        )
        ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, AppConstant.pageOfferRoute);
          },
          child: Container(
            width: width,
            height: 56.0,

            decoration: const BoxDecoration(color:AppColors.colorPrimary,borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0),topRight: Radius.circular(24.0))),
            child: Center(child: Text('investmentRequest'.tr(),style: const TextStyle(fontSize: 16.0,color: AppColors.white),)),
          ),
        )
      ],
    );
  }

  Widget _buildHeaderSection({required BuildContext context}) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double containerRatesHeight = 148;
    return SizedBox(
      height: width + containerRatesHeight/2,
      child: Stack(
        children: [
          SizedBox(
              width: width,
              height: width,
              child: Hero(
                tag: "investmentImage",
                child: Image.asset(
                  '${AppConstant.localImagePath}test.png',
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
            top: width - (containerRatesHeight / 2),
            child: SizedBox(
              width: width,
              height: containerRatesHeight,
              child: Card(
                color: AppColors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0)),
                child: _buildRateSection(context: context),
              ),
            ),
          ),
          Positioned(
              top: 16.0,
              left: 16.0,
              right: 16.0,
              child: Row(
                children: [
                  Card(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    elevation: 8.0,
                    child: AppWidget.buildBackArrow(
                        context: context, padding: 8.0, paddingAll: true),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildRateSection({required BuildContext context}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildProgressRate(
            context: context, progress: .40, title: 'ownershipRate'.tr()),
        _buildProgressRate(
            context: context, progress: .90, title: 'successRate'.tr()),

      ],
    );
  }

  Widget _buildProgressRate({required BuildContext context, required double progress, required String title}) {
    return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularPercentIndicator(
                radius:48.0,
                startAngle: 90,
                progressColor: AppColors.colorPrimary,
                animation: true,
                animateFromLastPercent: true,
                percent: progress,
                fillColor: AppColors.white,
                backgroundColor: AppColors.grey3,
                circularStrokeCap: CircularStrokeCap.round,
                lineWidth: 8.0,
                center:Text('${(progress*100).toInt()}%',style: const TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color: AppColors.color1),),
              ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.bold),
              ),

            ]
            ,
          ),
        )
    );
  }
  
  Widget _buildDetailsSection({required BuildContext context}){
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        elevation: 3.0,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Resturant',style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: AppColors.black),),
              const SizedBox(height: 8.0,),
              Text('Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever  Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy',style: const TextStyle(fontSize: 14.0,color: AppColors.black),),
              const SizedBox(height: 8.0,),
              Text('projectCost'.tr(),style: const TextStyle(fontSize: 14.0,color: AppColors.colorPrimary),),
              const SizedBox(height: 8.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppWidget.svg('cost.svg', AppColors.colorPrimary, 24.0, 24.0),
                  const SizedBox(width: 8.0,),
                  RichText(text: TextSpan(
                    text: '200,000',style: const TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color: AppColors.black),
                    children: [
                      TextSpan(text: 'sar'.tr(),style: const TextStyle(color: AppColors.black,fontSize: 14.0))
                    ]

                  ),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportSection({required BuildContext context}){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 0),
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        elevation: 3.0,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('consultantsReports'.tr(),style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: AppColors.black),),
              ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                return InvestmentDetailsWidgets().buildListItem(context: context, object: Object(), index: index, onTaped: _onTaped);
              })
            ],
          ),
        ),


      ),
    );
  }

  void _onTaped({required BuildContext buildContext,required Object object,required int index}){

  }

}
