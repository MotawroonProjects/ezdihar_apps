 class SubCategoryModel{
  late int id;
  late int subCategoryId;
  late String consultantTypeId;
  late int userId;
  late String descAr;
  late String descEn;
  late int price;

  SubCategoryModel();

   SubCategoryModel.factory(this.id, this.subCategoryId, this.consultantTypeId,
       this.userId, this.descAr, this.descEn, this.price);

   SubCategoryModel.fromJson(Map<String,dynamic> json){
    id = json['id'] as int;
    subCategoryId = json['sub_category_id'] as int;
    consultantTypeId = json['consultant_type_id']!=null?json['consultant_type_id'] as String:"";
    userId = json['user_id'] as int;
    descAr = json['desc_ar']!=null?json['desc_ar'] as String:"";
    descEn = json['desc_en']!=null?json['desc_en'] as String:"";
    price = json['price'] as int;


  }
  static Map<String,dynamic> toJson(SubCategoryModel model){
     return {
       'id':model.id,
       'sub_category_id':model.subCategoryId,
       'consultant_type_id':model.consultantTypeId,
       'user_id':model.userId,
       'desc_ar':model.descAr,
       'desc_en':model.descEn,
       'price':model.price,

     };
  }
}