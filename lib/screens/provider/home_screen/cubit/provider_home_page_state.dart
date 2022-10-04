part of 'provider_home_page_cubit.dart';

@immutable
abstract class ProviderHomePageState {}

class ProviderHomePageInitial extends ProviderHomePageState {}

class UserDataDone extends ProviderHomePageState {}


class ProviderHomePageLoading extends ProviderHomePageState {}
class ProviderHomePageLoaded extends ProviderHomePageState {
  final ProviderHomePageModel providerHomePageModel;

  ProviderHomePageLoaded(this.providerHomePageModel);
}
class ProviderHomePageError extends ProviderHomePageState {}
