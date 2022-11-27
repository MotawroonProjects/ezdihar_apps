import 'dart:async';
import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart' as local;
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/models/message_model.dart';

import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart%20' as gets;

import '../../constants/app_constant.dart';
import '../../models/chat_model.dart';
import '../../models/user_model.dart';
import '../../preferences/preferences.dart';
import '../../remote/notification.dart';
import '../../remote/notificationlisten.dart';
import '../../routes/app_routes.dart';
import 'cubit/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chatModel;

  const ChatPage({Key? key, required this.chatModel}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState(chatModel: chatModel);
}

class _ChatPageState extends State<ChatPage> {
  PushNotificationService? pushNotificationService;
  late ChatCubit cubit;
  ChatModel chatModel;
  String message = "";
  late Stream<LocalNotification> _notificationsStream;

  int user_id = 0;
  late FocusNode focusNode;

  bool needscroll = true;
  bool first = false;
  double current = 0;

  var _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  var hei, wid;

  bool isend = false;

  int position = 0;

  _ChatPageState({required this.chatModel});

  @override
  Widget build(BuildContext context) {
    _onRefresh();
    AppRoutes.rout = AppConstant.pageChatRoute;
    AppRoutes.chatmodel = null;
    gets.Get.addPage(gets.GetPage(
        name: AppConstant.pageChatRoute,
        page: () {
          throw Exception();
        }));

    print("d;ldkfkf${chatModel.user_id}");
    print("fkfkkfkfkfk${user_id}");
    //   WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());

    Size size = MediaQuery.of(context).size;
    hei = size.height;
    wid = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          title: Text(
            chatModel.user.id == user_id
                ? chatModel.provider.firstName +
                    " " +
                    chatModel.provider.lastName
                : chatModel.user.firstName + " " + chatModel.user.lastName,
            style: const TextStyle(
                color: AppColors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          flexibleSpace: SafeArea(
            right: true,
            bottom: true,
            top: true,
            child: Center(
                child: Row(
              children: [
                AppWidget.buildBackArrow(context: context),
                Container(
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context,
                              chatModel.user.id != user_id
                                  ? AppConstant.serviceRequestScreenRoute
                                  : AppConstant.OrdersNewScreenRoute,
                              arguments: chatModel);
                          // Add what you want to do on tap
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(chatModel.user_id == user_id
                                ? Icons.data_usage
                                : Icons.add),
                            SizedBox(width: 2.0),
                            Text(
                              chatModel.user_id != user_id
                                  ? "Add Request"
                                  : "Show Request",
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ))),
              ],
            )),
          )),
      backgroundColor: AppColors.grey2,
      body: buildBodySection(),
    );
  }

  buildBodySection() {
    cubit = BlocProvider.of<ChatCubit>(context);
    return BlocProvider(
        create: (context) {
          cubit.getChat(chatModel.id.toString());
          return cubit;
        },
        child: Column(mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is IsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.colorPrimary,
                      ),
                    );
                  } else if (state is OnDataSuccess || state is First) {
                    // ChatCubit cubit = BlocProvider.of<ChatCubit>(context);
                    //  print("fileName=>${state.data.length}");
                    if (position < cubit.list.length) {
                      needscroll = true;
                    }
                    if (needscroll) {
                      print("fileNamedddd=>${cubit.list.length}");
                      scrollToBottom(cubit.list.length);

                      //  needscroll=false;

                    }
                    print('sssss${cubit.first}');
                    return Container(
                        child: Opacity(
                            opacity: cubit.first ? 1 : 0,
                            child: ListView.builder(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: cubit.list.length + 1,
                              itemBuilder: (context, index) {
                                print("dlkdkdk${index.toString()}");
                                if (index < cubit.list.length &&
                                    cubit.list[index].from_user_id != 0) {
                                  MessageModel model = cubit.list[index];

                                  bool isme = model.from_user.id == user_id;
                                  return Opacity(
                                      opacity: cubit.first ? 1.0 : 0.0,
                                      child: Align(
                                          // align the child within the container
                                          alignment: isme
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Bubble(
                                            color: isme
                                                ? (model.type.contains("file")
                                                    ? AppColors.grey2
                                                    : AppColors.grey6)
                                                : (model.type.contains("file")
                                                    ? AppColors.grey2
                                                    : AppColors.grey4),
                                            margin: BubbleEdges.only(top: 10),
                                            nip: isme
                                                ? BubbleNip.rightBottom
                                                : BubbleNip.leftBottom,
                                            elevation:
                                                model.type.contains("file")
                                                    ? 0
                                                    : 2,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: (model.type
                                                        .contains("file")
                                                    ? CachedNetworkImage(
                                                        height: 290,
                                                        imageUrl: model.file,
                                                        placeholder: (context,
                                                                url) =>
                                                            Container(
                                                              color: AppColors
                                                                  .grey2,
                                                            ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                              color: AppColors
                                                                  .grey2,
                                                            ))
                                                    : Text(
                                                        model.message,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                        ),
                                                      ))),
                                          )));
                                } else {
                                  return Container();
                                }
                              },
                            )));
                  } else {
                    return InkWell(
                      onTap: () {
                        needscroll = true;
                        cubit.getChat(chatModel.id.toString());
                      },
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppWidget.svg('reload.svg', AppColors.colorPrimary,
                                24.0, 24.0),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              local.tr('reload'),
                              style: TextStyle(
                                  color: AppColors.colorPrimary,
                                  fontSize: 15.0),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              )),
              buildbottom()
              // BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
              //   String imagePath = cubit.imagePath;
              //   if (state is UserPhotoPicked) {
              //     imagePath = state.imagePath;
              //     cubit.sendimage(context, imagePath, chatModel);
              //   }
              //
              //   return Row(
              //     children: [
              //       IconButton(
              //         icon: Icon(Icons.photo),
              //         color: Theme.of(context).primaryColor,
              //         iconSize: 25.0,
              //         onPressed: () {
              //           buildAlertDialog();
              //         },
              //       ),
              //       Expanded(
              //           child: Container(
              //               margin: const EdgeInsets.all(15.0),
              //               padding: const EdgeInsets.all(3.0),
              //               decoration: BoxDecoration(
              //                   color: AppColors.white,
              //                   border: Border.all(color: AppColors.grey4),
              //                   borderRadius: BorderRadius.all(Radius.circular(8))),
              //               child: TextField(
              //                 controller: _controller,
              //                 onChanged: (value) {
              //                   message = value;
              //                 },
              //                 textCapitalization: TextCapitalization.sentences,
              //               ))),
              //       IconButton(
              //         icon: Icon(Icons.send),
              //         color: Theme.of(context).primaryColor,
              //         iconSize: 25.0,
              //         onPressed: () {
              //           cubit.sendmessage(context, message, chatModel);
              //           message = "";
              //           _controller.clear();
              //         },
              //       ),
              //     ],
              //   );
              // }),
            ]));
  }

  buildAlertDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<ChatCubit>(context),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    local.tr('choose_photo'),
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 1,
                    color: AppColors.grey3,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  InkWell(
                    onTap: () {
                      needscroll = true;
                      Navigator.pop(context);
                      BlocProvider.of<ChatCubit>(context).pickImage(
                          type: 'camera',
                          chatModel: chatModel,
                          context: context);
                    },
                    child: Text(
                      local.tr('camera'),
                      style: TextStyle(fontSize: 18.0, color: AppColors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  InkWell(
                    onTap: () {
                      needscroll = true;

                      Navigator.pop(context);
                      BlocProvider.of<ChatCubit>(context).pickImage(
                          type: 'gallery',
                          chatModel: chatModel,
                          context: context);
                    },
                    child: Text(
                      local.tr('gallery'),
                      style: TextStyle(fontSize: 18.0, color: AppColors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Container(
                    height: 1,
                    color: AppColors.grey3,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      local.tr('cancel'),
                      style: TextStyle(
                          fontSize: 18.0, color: AppColors.colorPrimary),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  buildbottom() {
    ChatCubit cubit = BlocProvider.of<ChatCubit>(context);

    return BlocProvider.value(
      value: BlocProvider.of<ChatCubit>(context),
      child: BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
        // if (state is UserPhotoPicked) {
        //   imagePath = state.imagePath;
        //   cubit.sendimage(context, imagePath, chatModel);
        // }

        return SingleChildScrollView(
            child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.photo),
              color: Theme.of(context).primaryColor,
              iconSize: 25.0,
              onPressed: () {
                buildAlertDialog();
              },
            ),
            Expanded(
                child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.grey4),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextField(
                      keyboardAppearance: Brightness.dark,
                      focusNode: focusNode,
                      onSubmitted: (value) => (value) {
                        needscroll = true;
                        //  cubit.list.add(new MessageModel());

                        scrollToBottom(cubit.list.length);
                      },
                      controller: _controller,
                      onChanged: (value) {
                        message = value;
                      },
                      textCapitalization: TextCapitalization.sentences,
                    ))),
            IconButton(
              icon: Icon(Icons.send),
              color: Theme.of(context).primaryColor,
              iconSize: 25.0,
              onPressed: () {
                needscroll = true;
                cubit.sendmessage(context, message, chatModel);
                //FocusScope.of(context).requestFocus(FocusNode());

                message = "";
                _controller.clear();
              },
            ),
          ],
        ));
      }),
    );
  }

  Future<void> _onRefresh() async {
    UserModel model = await Preferences.instance.getUserModel();
    user_id = model.user.id;
    setState(() {
      user_id;
    });
  }

  void scrollToBottom(int index) {
    // print('object${index}');
    // if (pcosition > 0 && position <= index) {
    //   index = index + 1;
    // }
    Future.delayed(Duration(milliseconds: 0), () {
      print('object${_scrollController.position.maxScrollExtent}');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController
            .animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 1),
              curve: Curves.easeInOut,
            )
            .whenComplete(() => cubit.setfirst());
      });
      // _scrollController.scrollTo(index: index,duration: Duration(milliseconds: 0));
      // _scrollController.scrollTo(
      //     index: index, duration: Duration(milliseconds: 1));
      position = index;
      needscroll = false;

      //  first = true;

      // if ( _scrollController.offset == _scrollController.position.pixels) {
      //   needscroll = false;
      // } else {
      //   needscroll = true;
      // }
    });
    // cubit.setfirst();
  }

  @override
  void initState() {
    super.initState();
    focusNode = new FocusNode();

    // listen to focus changes
    focusNode.addListener(() => scrollToBottom(0));
    _notificationsStream = NotificationsBloc.instance.notificationsStream;
    _notificationsStream.listen((event) {
      print("dlkdkdjjdjsssss${event.data}");
      cubit.list.add(MessageModel.fromJson(event.data));
      cubit.emit(OnDataSuccess(cubit.list));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    AppRoutes.rout = "";
    super.dispose();
  }

// void listenToNotificationStream() =>
//     pushNotificationService!.behaviorSubject.listen((payload) {
//       print("D;dldlldl");
//       ChatModel chatModel = pushNotificationService!.behaviorchat.value;
//       if (payload.contains("chat") && chatModel.id == this.chatModel.id) {
//         needscroll = true;
//         cubit.list.add(pushNotificationService!.behaviormessage.value);
//       }
//     });

}
