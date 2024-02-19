import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transmedia_project/DatabaseHandler/database_handler.dart';
import 'package:transmedia_project/Models/productlist_model.dart';
import 'package:transmedia_project/Utils/colors.dart';

import '../../Provider/auth_provider.dart';

class HomeController extends GetxController {
  final AuthProvider apiClient = AuthProvider();
  final dbHelper = DatabaseHelper.instance;
  List<ProductListModel> productList = [];
  List<ProductListModel> cartList = [];
  var isLoading = true.obs;
  var isCartLoading = true.obs;
  RxDouble totalPrice = 0.00.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getProductList();
    // getCartItems();
    super.onInit();
  }

  Future getProductList() async {
    await apiClient.getProductList().then((auth) {
      print("product_auth $auth");
      isLoading.value = false;
      if (auth != null) {
        productList = auth;
        print("productList - ${productList.length}");

        update();
      }
    }).catchError((err) {
      isLoading.value = false;
    });
  }

  addToCart(ProductListModel item) async {
    var itemData = item.toJson();

    final id = await dbHelper.insertProduct(itemData);

    if (id > 0) {
      update();
      snackbarAlert("Added to cart");
    }
  }

  deleteFromCart(int id, int price) async {
    final ok = await dbHelper.delete(id);

    if (ok > 0) {
      cartList.removeWhere((item) => item.id == id);
      totalPrice.value -= price;
      update();
      snackbarAlert("Deleted from cart");
    }
  }

  getCartItems() async {
    final listData = await dbHelper.getAllProducts();
    cartList =
        (listData).map((item) => ProductListModel.fromJson(item)).toList();
    isCartLoading.value = false;
    totalPrice.value = 0;
    for (int i = 0; i < cartList.length; i++) {
      String amt = cartList[i].userId!.toString();
      double doublePrice = double.parse(amt);
      totalPrice.value += doublePrice;
    }
    update();
  }

  snackbarAlert(String msg) {
    Get.snackbar("Trans Media", msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorUtil.primaryColor);
  }
}
