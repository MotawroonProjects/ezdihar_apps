part of 'conversation_page_cubit.dart';

@immutable
abstract class ConversationPageState {}
class IsLoadingData extends ConversationPageState {


  IsLoadingData();
}
class OnDataSuccess extends ConversationPageState {
  List<ChatModel> list;

  OnDataSuccess(this.list);
}


class OnError extends ConversationPageState {
  String error;
  OnError(this.error);
}
