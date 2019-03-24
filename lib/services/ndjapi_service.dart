import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demo/interfaces/ndj_api.dart';
import 'package:demo/models/product_list.dart';

class NdjapiService implements NdjApi {
  final _baseUrl = 'https://ndjtest.com/mobileapi';
  http.Client _client = http.Client();

  set client(http.Client value) => _client = value;

  static final NdjapiService _internal = NdjapiService.internal();
  factory NdjapiService() => _internal;
  NdjapiService.internal();

  Future<ProductList> getProduct() async {
    var response = await _client.get('$_baseUrl/index/index');

    if (response.statusCode == 200) {

        return getProductFromjson(response.body);


    } else {
      throw Exception('Failed to get data');
    }
  }

  ProductList getProductFromjson(String str){

    final json = jsonDecode(str);
    return ProductList.fromJson(json);

  }


}