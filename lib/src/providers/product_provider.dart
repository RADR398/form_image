

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:formvalidation/src/models/product.dart';

class ProductProvider {
  final String _url = 'https://quantum-keep-257315.firebaseio.com';

  Future<bool> createProduct(ProductModel prod)async{
    final url = '$_url/products.json';

    final Response response = await Dio().post(url,data: prod.toJson());

    print(response.data.toString());

    return true;

  }

  Future<bool> editProduct(ProductModel prod)async{
    final url = '$_url/products/${prod.id}.json';

    final Response response = await Dio().put(url,data: prod.toJson());

    print(response.data.toString());

    return true;

  }

  Future<List<ProductModel>> getProduct() async {
    final url = '$_url/products.json';
    final List<ProductModel> products = List<ProductModel>();

    final Response response = await Dio().get(url);
    (response.data as Map<String,dynamic>).forEach((id,prod){
      //products.add(ProductModel(id: id,title: prod['title'],value: prod['value'],available: prod['available']));
      final prodTemp = ProductModel.fromMap(prod);
      prodTemp.id = id;
      products.add(prodTemp);
    });
    return products;
  }

  Future<int> deleteProduct(String id) async {
    final url = '$_url/products/$id.json';
    final resp = await Dio().delete(url);
    return 1;
  }
}