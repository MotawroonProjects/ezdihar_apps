part of 'contact_us_cubit.dart';

@immutable
abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}
class ContactUsLoading extends ContactUsState {}
class ContactUsLoaded extends ContactUsState {}
class ContactUsError extends ContactUsState {}
class CorrectEmail extends ContactUsState {}
