part of 'consultant_cubit.dart';

@immutable
abstract class ConsultantState {}

class ConsultantInitial extends ConsultantState {}

class ConsultantFilePicked extends ConsultantState {
  String fileName;
  ConsultantFilePicked(this.fileName);
}

class ConsultantYearsChanged extends ConsultantState {
  String years;
  ConsultantYearsChanged(this.years);
}


class ConsultantDataValidation extends ConsultantState {
  bool valid;
  ConsultantDataValidation(this.valid);

}