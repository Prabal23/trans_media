import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:basic_ui_package/basic_ui_package.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:transmedia_project/ProductPage/controller/home_controller.dart';

import '../../Services/UIServices/ui_service.dart';
import '../../Utils/colors.dart';
import '../../Utils/product_loader/product_loader.dart';

class CartPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.getCartItems();
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
                      Container(
                        padding: EdgeInsets.all(10),
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GetBuilder<HomeController>(
                  builder: (_) {
                    return controller.isCartLoading.value == true
                        ? Column(
                            children: List.generate(
                                5, (index) => const ProductLoader()),
                          )
                        : controller.cartList.isEmpty
                            ? UIText("No products added to the cart",
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: ColorUtil.priceColor,
                                basicUiPackage: UiService.basicUiPackageInit)
                            : Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  children: List.generate(
                                      controller.cartList.length, (index) {
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: CachedNetworkImage(
                                              width: 90,
                                              height: 90,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  "${controller.productList[index].thumbnail}",
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                UIText(
                                                    "${controller.cartList[index].title}",
                                                    fontSize: 14,
                                                    maxLine: 2,
                                                    textOverFlow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: ColorUtil.priceColor,
                                                    textAlign: TextAlign.start,
                                                    basicUiPackage: UiService
                                                        .basicUiPackageInit),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                UIText(
                                                    "\$${controller.cartList[index].userId}",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorUtil.priceColor,
                                                    textAlign: TextAlign.center,
                                                    basicUiPackage: UiService
                                                        .basicUiPackageInit),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.remove_circle_outline,
                                                    color:
                                                        ColorUtil.primaryColor,
                                                    size: 25,
                                                  ),
                                                ),
                                                UIText("1",
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: ColorUtil.priceColor,
                                                    textAlign: TextAlign.start,
                                                    basicUiPackage: UiService
                                                        .basicUiPackageInit),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.add_circle_outline,
                                                    color:
                                                        ColorUtil.primaryColor,
                                                    size: 25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.deleteFromCart(
                                                  controller
                                                      .cartList[index].id!,
                                                  controller
                                                      .cartList[index].userId!);
                                            },
                                            child: Container(
                                                height: 100,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.redAccent,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    )),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIText("Total",
                      fontSize: 16,
                      maxLine: 1,
                      textOverFlow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.normal,
                      color: ColorUtil.boardingSubTitleColor,
                      textAlign: TextAlign.center,
                      basicUiPackage: UiService.basicUiPackageInit),
                  Obx(
                    () => UIText("\$${controller.totalPrice.value}",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorUtil.priceColor,
                        textAlign: TextAlign.center,
                        basicUiPackage: UiService.basicUiPackageInit),
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: ColorUtil.primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: UIText("Checkout",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                      basicUiPackage: UiService.basicUiPackageInit)),
            ],
          ),
        ));
  }
}
