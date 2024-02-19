import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:basic_ui_package/basic_ui_package.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:transmedia_project/Models/productlist_model.dart';

import '../../Services/UIServices/ui_service.dart';
import '../../Utils/colors.dart';
import '../../Utils/route_name.dart';
import '../controller/home_controller.dart';
import 'cart_page.dart';

class ProductDetailsPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    ProductListModel productListModel = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      child: UIText("Product",
                          textAlign: TextAlign.center,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          basicUiPackage: UiService.basicUiPackageInit),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesName.CART_PAGE);
                      },
                      child: Image.asset(
                        "assets/images/cart_icon.png",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        fit: BoxFit.cover,
                        imageUrl: "${productListModel.thumbnail}",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UIText("${productListModel.title}",
                        textAlign: TextAlign.start,
                        color: ColorUtil.signUpColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        basicUiPackage: UiService.basicUiPackageInit),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UIText("\$${productListModel.userId}",
                            textAlign: TextAlign.center,
                            color: ColorUtil.primaryColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            basicUiPackage: UiService.basicUiPackageInit),
                        GestureDetector(
                          onTap: () {
                            controller.addToCart(productListModel);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: ColorUtil.primaryColor,
                                borderRadius: BorderRadius.circular(25)),
                            child: Row(
                              children: [
                                UIText("Add to cart",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    textAlign: TextAlign.center,
                                    basicUiPackage:
                                        UiService.basicUiPackageInit),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.add_shopping_cart_outlined,
                                  size: 17,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    UIText("${productListModel.content}",
                        textAlign: TextAlign.justify,
                        color: ColorUtil.signUpColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        basicUiPackage: UiService.basicUiPackageInit),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
