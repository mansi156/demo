import 'package:demo/model/banner.dart';
import 'package:demo/model/category_data.dart';

class Data{

  String contactNumber;
  List<Banner> banner;
  List<CategoryData> categoryData;


  Data({this.contactNumber, this.banner, this.categoryData});

  factory Data.fromJson(Map<String,dynamic> json)=>new Data(

      categoryData:new List<CategoryData>.from(json["categoryData"].map((x) => CategoryData.fromJson(x))),
      banner:new List<Banner>.from(json["banner"].map((x) => Banner.fromJson(x))),
      contactNumber:json["contact_number"]

  );

  @override
  String toString() {
    return 'Data{contactNumber: $contactNumber, banner: $banner, categoryData: $categoryData}';
  }


}