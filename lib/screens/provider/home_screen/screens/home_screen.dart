import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/provider_home_page_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/home_card_view_widget.dart';
import '../widgets/statistics_widget.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
          )),
      backgroundColor: AppColors.grey7,
      body: RefreshIndicator(
        onRefresh: ()async{
          context.read<ProviderHomePageCubit>().getHomePageData();
        },
        child: SafeArea(
          child: BlocConsumer<ProviderHomePageCubit, ProviderHomePageState>(
            listener: (context, state) {
              if (state is UserDataDone) {
                context.read<ProviderHomePageCubit>().getHomePageData();
              }
            },
            builder: (context, state) {
              if (state is ProviderHomePageLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.colorPrimary,
                  ),
                );
              } else if (state is ProviderHomePageLoaded) {
                return Column(
                  children: [
                    CustomAppBar(
                      user: context.read<ProviderHomePageCubit>().user!.user,
                    ),
                    SizedBox(height: 30),
                    StatisticsWidget(),
                    SizedBox(height: 30),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            childAspectRatio: 7 / 10,
                            mainAxisSpacing: 12,
                          ),
                          itemBuilder: (context, index) => ProviderHomeCardWidget(
                            index: index,
                            orders: state.providerHomePageModel.orders!,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator(
                  color: AppColors.colorPrimary,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
