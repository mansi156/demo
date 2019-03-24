import 'package:demo/models/item.dart';


class ChildrenData{



  String name;
  List<Item> itemList;

  ChildrenData({this.name, this.itemList});



  factory ChildrenData.fromJson(Map<String,dynamic>json) =>new ChildrenData(


      name : json["name"],
      itemList:  new List<Item>.from(json["items"].map((x) => Item.fromJson(x)))
  );

  @override
  String toString() {
    return 'ChildrenData{name: $name, itemList: $itemList}';
  }


}