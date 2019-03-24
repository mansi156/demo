import 'dart:async';
import 'package:demo/models/product_list.dart';



abstract class NdjApi {
  Future<ProductList> getProduct();

}