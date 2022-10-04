import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_role_state.dart';

class UserRoleCubit extends Cubit<UserRoleState> {
  String role='';
  UserRoleCubit() : super(UserRoleInitial(''));


  void updateRole(String role){
    this.role = role;
    emit(UserRoleInitial(role));
  }
}
