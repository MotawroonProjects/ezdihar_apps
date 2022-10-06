import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/models/message_model.dart';

import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat_model.dart';
import '../../models/user_model.dart';
import '../../preferences/preferences.dart';
import 'cubit/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chatModel;

  const ChatPage({Key? key, required this.chatModel}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState(chatModel: chatModel);
}

class _ChatPageState extends State<ChatPage> {
  ChatModel chatModel;
  String message = "";
  int user_id = 0;
  var _controller = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  var hei, wid;
  bool _firstAutoscrollExecuted = false;
  bool _shouldAutoscroll = false;

  _ChatPageState({required this.chatModel});

  @override
  Widget build(BuildContext context) {
    _onRefresh();
    Size size = MediaQuery.of(context).size;
    hei = size.height;
    wid = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          chatModel.user.id == user_id
              ? chatModel.provider.firstName + " " + chatModel.provider.lastName
              : chatModel.user.firstName + " " + chatModel.user.lastName,
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey2,
      body: buildBodySection(),
    );
  }

  buildBodySection() {
    ChatCubit cubit = BlocProvider.of<ChatCubit>(context);
    return BlocProvider(
        create: (context) {
          cubit.getChat(chatModel.id.toString());
          return cubit;
        },
        child: Column(children: [
          Expanded(child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is IsLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.colorPrimary,
                  ),
                );
              } else if (state is OnDataSuccess) {
                ChatCubit cubit = BlocProvider.of<ChatCubit>(context);
                print(cubit.list.length);
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: cubit.list.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      MessageModel model = cubit.list[index];

                      bool isme = model.from_user.id == user_id;
                      if (cubit.list.length > 0) {
                        if (_scrollController.hasClients) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent);
                          });
                        }
                      }
                      return Align(
                          // align the child within the container

                          alignment: isme
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Bubble(
                            color:
                                isme ? AppColors.colorPrimary : AppColors.grey4,
                            margin: BubbleEdges.only(top: 10),
                            nip: isme
                                ? BubbleNip.rightBottom
                                : BubbleNip.leftBottom,
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: (model.type.contains("file")
                                    ? CachedNetworkImage(
                                        imageUrl: model.file,
                                        placeholder: (context, url) =>
                                            Container(
                                              color: AppColors.grey2,
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              color: AppColors.grey2,
                                            ))
                                    : Text(
                                        model.message,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        ),
                                      ))),
                          ));
                    });
              } else {
                OnError error = state as OnError;
                return InkWell(
                  onTap: () {
                    cubit.getChat(chatModel.id.toString());
                  },
                  child: Center(
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
                  ),
                );
              }
            },
          )),
          BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
            String imagePath = cubit.imagePath;
            if (state is UserPhotoPicked) {
              imagePath = state.imagePath;
              cubit.sendimage(context, imagePath, chatModel);
            }

            return Row(
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
                    cubit.sendmessage(context, message, chatModel);
                    message = "";
                    _controller.clear();
                  },
                ),
              ],
            );
          }),
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
                    'choose_photo'.tr(),
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
                      Navigator.pop(context);
                      BlocProvider.of<ChatCubit>(context)
                          .pickImage(type: 'camera');
                    },
                    child: Text(
                      'camera'.tr(),
                      style: TextStyle(fontSize: 18.0, color: AppColors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      BlocProvider.of<ChatCubit>(context)
                          .pickImage(type: 'gallery');
                    },
                    child: Text(
                      'gallery'.tr(),
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
                      'cancel'.tr(),
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
        String imagePath = cubit.imagePath;
        if (state is UserPhotoPicked) {
          imagePath = state.imagePath;
          cubit.sendimage(context, imagePath, chatModel);
        }

        return Row(
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
                cubit.sendmessage(context, message, chatModel);
                message = "";
                _controller.clear();
              },
            ),
          ],
        );
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

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      Timer.run(() {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          _scrollController.addListener(_scrollListener);
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    _firstAutoscrollExecuted = true;

    if (_scrollController.hasClients &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _shouldAutoscroll = true;
    } else {
      _shouldAutoscroll = false;
    }
  }
}
