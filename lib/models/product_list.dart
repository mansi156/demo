import 'package:demo/models/response.dart';

class ProductList{

  Response response;
  ProductList({this.response});


  factory ProductList.fromJson(Map<String,dynamic> json) => new ProductList(

      response: Response.fromJson(json["response"])

  );

  @override
  String toString() {
    return 'ProductList{response: $response}';
  }


}