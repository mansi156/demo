import 'dart:async';
import 'package:meta/meta.dart';
import 'package:demo/models/product_list.dart';
import 'package:demo/interfaces/ndj_api.dart';
import 'package:scoped_model/scoped_model.dart';

class MainPageViewModel extends Model {
  Future<ProductList> _productlist;
  Future<ProductList> get product => _productlist;

  set product(Future<ProductList> value) {
    _productlist = value;
    notifyListeners();
  }
  final NdjApi apiSvc;

  MainPageViewModel({@required this.apiSvc});

  Future<bool> setProduct() async {
    product = apiSvc?.getProduct();
    return product != null;
  }



}