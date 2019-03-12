import 'package:demo/model/children_data.dart';

class CategoryData{


  String name;
  List<ChildrenData> childData;

  CategoryData({this.name, this.childData});



  factory CategoryData.fromJson(Map<String,dynamic>json)=>new CategoryData(



      name:json["name"],
      childData:new List<ChildrenData>.from(json["children_data"].map((x) => ChildrenData.fromJson(x)))

  );

  @override
  String toString() {
    return 'CategoryData{name: $name, childData: $childData }';
  }


}