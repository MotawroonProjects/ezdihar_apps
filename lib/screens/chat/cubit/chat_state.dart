part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class IsLoading extends ChatState {}

class OnDataSuccess extends ChatState {
  List<MessageModel> data;
  OnDataSuccess(this.data);
}
class UserPhotoPicked extends ChatState {
  String imagePath;

  UserPhotoPicked(this.imagePath);
}
class OnError extends ChatState {
  String error;

  OnError(this.error);
}
