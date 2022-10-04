import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../colors/colors.dart';
import '../../constants/convert_numbers_method.dart';
import '../../models/user.dart';
import '../../widgets/app_widgets.dart';
import 'cubit/wallet_cubit.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'wallet'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey3,
      body: BlocConsumer<WalletCubit, WalletState>(
        listener: (context, state) {
          if (state is WalletLoading) {
            AppWidget.createProgressDialog(context, 'wait'.tr());
          }
        },
        builder: (BuildContext context, state) {
          if (state is GetUserModel) {
            return _buildBodySection(state.model.user);
          } else if (state is GetWalletModel) {
            return WebView(
              initialUrl: state.model.data!.payData!.transaction!.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController) {
                Navigator.pop(context);
              },
              onPageStarted: (text) {
                if (text.contains(
                    "https://ezdhar.motaweron.com/api/order/goThroughUrl/")) {
                  if (text.substring(52, 55) == "yes" ||
                      text.substring(52, 55) == "no/") {
                    Navigator.of(context).pop();
                  }
                }
              },
              onPageFinished: (text) {
                if (text.contains(
                    "https://ezdhar.motaweron.com/api/order/goThroughUrl/")) {
                  if (text.substring(52, 55) == "yes" ||
                      text.substring(52, 55) == "no/") {
                    context.read<WalletCubit>().onGetProfileData();
                  }
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildBodySection(User user) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    double width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 9.0),
              child: SizedBox(
                width: width,
                child: Card(
                    color: AppColors.white,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    margin: const EdgeInsets.all(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              user != null
                                  ? CachedNetworkImage(
                                      imageUrl: user.image,
                                      placeholder: (context, url) =>
                                          AppWidget.circleAvatar(96.0, 96.0),
                                      errorWidget: (context, url, error) =>
                                          AppWidget.circleAvatar(96.0, 96.0),
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        backgroundImage: imageProvider,
                                      ),
                                    )
                                  : AppWidget.circleAvatar(96.0, 96.0),
                              const SizedBox(
                                width: 16.0,
                              ),
                              Text(
                                '${user.firstName} ${user.lastName}',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Container(
                            height: 1.0,
                            color: AppColors.grey5,
                          ),
                          const SizedBox(
                            height: 48.0,
                          ),
                          Text(
                            'currentBalance'.tr(),
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey1),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          SizedBox(
                            width: 230,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppWidget.svg('wallet2.svg',
                                    AppColors.colorPrimary, 36.0, 36.0),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          text: lang == 'ar'
                                              ? "${replaceToArabicNumber("${user.wallet}")} "
                                              : " ${user.wallet}",
                                          style: const TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black),
                                          children: [
                                            TextSpan(
                                                text: 'sar'.tr(),
                                                style: const TextStyle(
                                                    fontSize: 24.0,
                                                    color: AppColors.black))
                                          ])),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                color: AppColors.color4,
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'balanceAvailableForWithdrawal'.tr(),
                                  style: const TextStyle(
                                      color: AppColors.grey6, fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                              text: lang == 'ar'
                                                  ? "${replaceToArabicNumber("1,000")} "
                                                  : " 1,000 ",
                                              style: const TextStyle(
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black),
                                              children: [
                                                TextSpan(
                                                    text: 'sar'.tr(),
                                                    style: const TextStyle(
                                                        fontSize: 14.0,
                                                        color: AppColors.black))
                                              ])),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<WalletCubit>()
                                            .onRechargeWallet(1000);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                color: AppColors.colorPrimary,
                                                width: 1.0)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'request'.tr(),
                                              style: const TextStyle(
                                                  color: AppColors.colorPrimary,
                                                  fontSize: 14.0),
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Transform.rotate(
                                                angle: lang == 'ar' ? 3.14 : 0,
                                                child: AppWidget.svg(
                                                    'arrow.svg',
                                                    AppColors.colorPrimary,
                                                    24.0,
                                                    24.0)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                color: AppColors.color4,
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'balanceAvailableForWithdrawal'.tr(),
                                  style: const TextStyle(
                                      color: AppColors.grey6, fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                              text: lang == 'ar'
                                                  ? "${replaceToArabicNumber("1,500")} "
                                                  : " 1,500 ",
                                              style: const TextStyle(
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black),
                                              children: [
                                                TextSpan(
                                                    text: 'sar'.tr(),
                                                    style: const TextStyle(
                                                        fontSize: 14.0,
                                                        color: AppColors.black))
                                              ])),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<WalletCubit>()
                                            .onRechargeWallet(1500);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                color: AppColors.colorPrimary,
                                                width: 1.0)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'request'.tr(),
                                              style: const TextStyle(
                                                  color: AppColors.colorPrimary,
                                                  fontSize: 14.0),
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Transform.rotate(
                                                angle: lang == 'ar' ? 3.14 : 0,
                                                child: AppWidget.svg(
                                                    'arrow.svg',
                                                    AppColors.colorPrimary,
                                                    24.0,
                                                    24.0)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                color: AppColors.color4,
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'balanceAvailableForWithdrawal'.tr(),
                                  style: const TextStyle(
                                      color: AppColors.grey6, fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                              text: lang == 'ar'
                                                  ? "${replaceToArabicNumber("2,000")} "
                                                  : " 2,000 ",
                                              style: const TextStyle(
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black),
                                              children: [
                                                TextSpan(
                                                    text: 'sar'.tr(),
                                                    style: const TextStyle(
                                                        fontSize: 14.0,
                                                        color: AppColors.black))
                                              ])),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<WalletCubit>()
                                            .onRechargeWallet(2000);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                color: AppColors.colorPrimary,
                                                width: 1.0)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'request'.tr(),
                                              style: const TextStyle(
                                                  color: AppColors.colorPrimary,
                                                  fontSize: 14.0),
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Transform.rotate(
                                                angle: lang == 'ar' ? 3.14 : 0,
                                                child: AppWidget.svg(
                                                    'arrow.svg',
                                                    AppColors.colorPrimary,
                                                    24.0,
                                                    24.0)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 48.0,
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  context.read<WalletCubit>().onGetProfileData();
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5.0),
                    minimumSize: MaterialStateProperty.all(const Size(160, 50)),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.colorPrimary),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)))),
                icon: AppWidget.svg(
                    'circle_add.svg', AppColors.white, 24.0, 24.0),
                label: Text(
                  'addBalance'.tr(),
                  style:
                      const TextStyle(color: AppColors.white, fontSize: 14.0),
                )),
          ],
        ),
      ],
    );
  }
}
