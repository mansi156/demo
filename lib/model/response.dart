import 'package:demo/model/data.dart';

class Response{

  String code;
  String message;
  Data data;

  Response({this.code, this.message, this.data});


  factory Response.fromJson(Map<String,dynamic> json)=>new Response(

      code: json["code"],
      message: json["message"],
      data: Data.fromJson(json["data"])

  );

  @override
  String toString() {
    return 'Response{code: $code, message: $message, data: $data}';
  }


}