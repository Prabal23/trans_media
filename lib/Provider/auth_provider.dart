import 'package:dio/dio.dart';
import 'package:transmedia_project/Models/productlist_model.dart';

import '../Utils/app_urls.dart';

class AuthProvider {
  Future<List<ProductListModel>?> getProductList() async {
    print("product_url ${AppUrl.getProducts}");
    Response response = await Dio().get(
      AppUrl.getProducts,
      options: Options(validateStatus: (_) => true),
    );

    print("product_response ${response.statusCode} / ${response.data}");
    if (response.statusCode == 200) {
      // return response.data;
      return (response.data as List)
          .map((x) => ProductListModel.fromJson(x))
          .toList();
    } else {
      return null;
    }
  }

  Future<List<ProductListModel>?> getProductDetails(int id) async {
    String url = "${AppUrl.getProducts}/$id";
    Response response = await Dio().get(
      url,
      options: Options(validateStatus: (_) => true),
    );

    print("product_det_response ${response.statusCode} / ${response.data}");
    if (response.statusCode == 200) {
      // return response.data;
      return (response.data as List)
          .map((x) => ProductListModel.fromJson(x))
          .toList();
    } else {
      return null;
    }
  }
}
