part of 'control_services_cubit.dart';

@immutable
abstract class ControlServicesState {}

class ControlServicesInitial extends ControlServicesState {}

class ControlServicesLoading extends ControlServicesState {}
class ControlServicesLoaded extends ControlServicesState {}
class ControlServicesError extends ControlServicesState {}
class ChangeCheckBoxValue extends ControlServicesState {}
class NewServiceAdded extends ControlServicesState {}
