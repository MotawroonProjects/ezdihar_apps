 class ServiceRequestModel{
  late int id;
  late int subCategoryId;
  late String consultantTypeId;
  late int userId;
  late String descAr;
  late String descEn;
  late int price;

  ServiceRequestModel();

  ServiceRequestModel.factory(this.id, this.subCategoryId, this.consultantTypeId,
       this.userId, this.descAr, this.descEn, this.price);

   ServiceRequestModel.fromJson(Map<String,dynamic> json){
    id = json['id']!=null? json['id'] as int:0;
    subCategoryId = json['sub_category_id']!=null?json['sub_category_id'] as int:0;
    consultantTypeId = json['consultant_type_id']!=null?json['consultant_type_id'] as String:"";
    userId = json['user_id']!=null? json['user_id'] as int:0;
    descAr = json['desc_ar']!=null?json['desc_ar'] as String:"";
    descEn = json['desc_en']!=null?json['desc_en'] as String:"";
    price = json['price']!=null? json['price'] as int:0;


  }
   Map<String,dynamic> toJson(ServiceRequestModel? model){
     if(model!=null){
     return {
       'id':model.id,
       'sub_category_id':model.subCategoryId,
       'consultant_type_id':model.consultantTypeId,
       'user_id':model.userId,
       'desc_ar':model.descAr,
       'desc_en':model.descEn,
       'price':model.price,
     };}
     return{};
  }
}