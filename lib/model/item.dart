
class Item{



  String name;
  String image;

  Item({this.name, this.image});


  factory Item.fromJson(Map<String,dynamic> json)=> new Item(


      name:json["name"],
      image:json["image"]
  );

  @override
  String toString() {
    return 'Item{name: $name, image: $image}';
  }


}