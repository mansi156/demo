
class Banner{

  String image;


  Banner({this.image});

  factory Banner.fromJson(Map<String, dynamic> json) => new Banner(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };

  @override
  String toString() {
    return 'Banner{image: $image}';
  }


}