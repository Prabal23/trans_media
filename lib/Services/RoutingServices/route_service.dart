import 'package:get/get.dart';
import 'package:transmedia_project/ProductPage/binding/home_bindings.dart';
import 'package:transmedia_project/ProductPage/views/cart_page.dart';
import 'package:transmedia_project/ProductPage/views/product_details_page.dart';
import 'package:transmedia_project/ProductPage/views/product_page.dart';

import '../../Utils/route_name.dart';

// final box = GetStorage('aisolution');
// var loginAuth = box.read('auth');

final List<GetPage> approuter = [
  GetPage(
      name: RoutesName.HOME,
      page: () => ProductPage(),
      binding: HomeBinding()),
  GetPage(
      name: RoutesName.HOME_DETAILS_PAGE,
      page: () => ProductDetailsPage(),
      binding: HomeBinding()),
  GetPage(
      name: RoutesName.CART_PAGE,
      page: () => CartPage(),
      binding: HomeBinding()),
];
