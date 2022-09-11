 class CategoryModel{
  late int id;
  late String title_ar;
  late String title_en;
  late String image;
  CategoryModel.initValues(){
    id = 0;
    title_ar ='إختر القسم';
    title_en = 'Choose category';
  }
  CategoryModel();
  CategoryModel.factory(this.id,this.title_ar,this.title_en,this.image);
  CategoryModel.fromJson(Map<String,dynamic> json){
    id = json['id'] as int;
    title_ar = json['title_ar']!=null?json['title_ar'] as String:"";
    title_en = json['title_en']!=null?json['title_en'] as String:"";
    image = json['image']!=null?json['image'] as String:"";


  }
  static Map<String,dynamic> toJson(CategoryModel model){
     return {
       'id':model.id,
       'title_ar':model.title_ar,
       'title_en':model.title_en,
       'image':model.image,

     };
  }
}