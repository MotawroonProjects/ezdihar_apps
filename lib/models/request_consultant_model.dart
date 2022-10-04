class RequestConsultationModel{
  String projectName='';
  String details ='';

  bool isDataValid(){
    if(projectName.isNotEmpty&&details.isNotEmpty){
      return true;
    }

    return false;
  }
}