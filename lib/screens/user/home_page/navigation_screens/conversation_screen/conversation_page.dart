import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/chat_model.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/conversation_screen/cubit/conversation_page_cubit.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/conversation_screen/widget/accounting_chat_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_reload/auto_reload.dart';
import '../../../../../colors/colors.dart';
import '../../../../../constants/app_constant.dart';
import '../../../../../models/user_model.dart';
import '../../../../../preferences/preferences.dart';
import '../../../../../remote/notificationlisten.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../widgets/app_widgets.dart';
import '../../../../provider/navigation_bottom/cubit/navigator_bottom_cubit.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key}) : super(key: key);
  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  var hei,wid;

  int user_id=0;
  late Stream<LocalNotification> _notificationsStream;

  late ConversationPageCubit cubit;
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    hei = size.height;
    wid = size.width;
    return Scaffold(

      // appBar: AppBar(
      //   backgroundColor: AppColors.white,
      //   centerTitle: true,
      //   elevation: 0,
      //   title: Text(
      //     'chat'.tr(),
      //     style: const TextStyle(
      //         color: AppColors.black,
      //         fontSize: 16.0,
      //         fontWeight: FontWeight.bold),
      //   ),
      //   leading:  context.read<NavigatorBottomCubit>().page != 1
      //       ? AppWidget.buildBackArrow(context: context)
      //       : SizedBox(),
      // ),
      backgroundColor: AppColors.grey2,
      body: buildBodySection(),
    );
  }
  @override
  void dispose() {

    super.dispose();
   // AppRoutes.rout = "";
  }
  @override
  void initState() {
    AppRoutes.rout ="conversation";
   // refreshCurrent();
    super.initState();
    _onRefresh();
    _notificationsStream = NotificationsBloc.instance.notificationsStream;
    _notificationsStream.listen((event) {
      print("dlkdkdjjdjsssss${event.data}");
     refreshCurrent();
    });

  }




  buildBodySection() {

    return BlocProvider(
      create: (context) {
         cubit =  ConversationPageCubit();
        cubit.getData();
        return cubit;
      },
      child: BlocBuilder<ConversationPageCubit, ConversationPageState>(
        builder: (context, state) {
          if (state is IsLoadingData) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.colorPrimary,
              ),
            );
          }
          else if (state is OnError) {
            return Center(
                child: InkWell(
                  onTap:()=>onRefresh(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppWidget.svg(
                          'reload.svg', AppColors.colorPrimary, 24.0, 24.0),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'reload'.tr(),
                        style: TextStyle(
                            color: AppColors.colorPrimary, fontSize: 15.0),
                      )
                    ],
                  ),
                ));
          }
          else {
            ConversationPageCubit cubit = BlocProvider.of<ConversationPageCubit>(context);

            List<ChatModel> list = cubit.chatmodelList;
            print(list.length);
            if (list.length > 0) {
              return RefreshIndicator(
                  color: AppColors.colorPrimary,
                  onRefresh: refreshCurrent,
                  child: ListView.builder(
                  itemCount: list.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: ((context, index) {
                    ChatModel model = list[index];
                    return InkWell(
                      onTap: () => _onTaped(chatModel: model, index: index),
                      child: AccountingChatWidgets().buildListItem(
                          context: context, model: model,user_id: user_id, index: index),
                    );
                  })));
             }else {
              return RefreshIndicator(
                  color: AppColors.colorPrimary,
                  onRefresh: refreshCurrent,
               child: Center(
                  child: Text(
                    'no_room'.tr(),
                    style: TextStyle(color: AppColors.black, fontSize: 15.0),
                  )));
            }
          }
        },
      ),
    );
  }


  void _onTaped({required ChatModel chatModel, required int index}) {
    Navigator.pushNamed(context, AppConstant.pageChatRoute,arguments:  chatModel);
  }
  Future<void> onRefresh(BuildContext context) async {
    ConversationPageCubit cubit = BlocProvider.of<ConversationPageCubit>(context);
    cubit.getData();
  }
  Future<void> _onRefresh() async {
    UserModel model = await Preferences.instance.getUserModel();
    user_id = model.user.id;
    setState(() {
      user_id;
    });
  }
  Future<void> refreshCurrent() async {
  cubit.getData();
}
}
