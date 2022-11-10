import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../models/chat_model.dart';
import '../screens/chat/chat_page.dart';
import '../screens/chat/cubit/chat_cubit.dart';
import 'app_routes.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(ChatModel chatModel) {
    return navigationKey.currentState!.push(MaterialPageRoute(
        builder: (context) => BlocProvider(
              create: (context) => ChatCubit(),
              child: ChatPage(
                chatModel: chatModel,
              ),
            )));
  }

  goback() {
    return navigationKey.currentState!.pop();
  }
}
