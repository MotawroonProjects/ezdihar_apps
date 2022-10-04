part of 'user_role_cubit.dart';

@immutable
abstract class UserRoleState {}

class UserRoleInitial extends UserRoleState {
  String role;

  UserRoleInitial(this.role);
}
