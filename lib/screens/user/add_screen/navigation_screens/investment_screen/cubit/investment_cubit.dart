import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/project_model.dart';
import 'package:meta/meta.dart';

part 'investment_state.dart';

class InvestmentCubit extends Cubit<InvestmentState> {
  late List<ProjectModel> projects;
  InvestmentCubit() : super(IsCategoryLoading()){}
}
