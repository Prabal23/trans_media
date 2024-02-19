import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:basic_ui_package/basic_ui_package.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transmedia_project/ProductPage/controller/home_controller.dart';
import 'package:transmedia_project/ProductPage/views/cart_page.dart';
import 'package:transmedia_project/ProductPage/views/product_details_page.dart';
import 'package:transmedia_project/Services/UIServices/ui_service.dart';
import 'package:transmedia_project/Utils/colors.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:transmedia_project/Utils/product_loader/product_loader.dart';

import '../../Utils/route_name.dart';

class ProductPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
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
                margin: EdgeInsets.all(20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorUtil.primaryColor,
                          ),
                          child: UIText("TM",
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              basicUiPackage: UiService.basicUiPackageInit)),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: UIText("Trans Media",
                            textAlign: TextAlign.center,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            basicUiPackage: UiService.basicUiPackageInit),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutesName.CART_PAGE);
                        },
                        child: Image.asset(
                          "assets/images/cart_icon.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () => controller.isLoading.value == true
                    ? Column(
                        children:
                            List.generate(5, (index) => const ProductLoader()),
                      )
                    : Column(
                        children: List.generate(controller.productList.length,
                            (index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(RoutesName.HOME_DETAILS_PAGE,
                                  arguments: controller.productList[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      width: 0.1,
                                      color: ColorUtil.boardingSubTitleColor)),
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 5, bottom: 5),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "${controller.productList[index].thumbnail}",
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        UIText(
                                            "${controller.productList[index].title}",
                                            fontSize: 15,
                                            maxLine: 1,
                                            textOverFlow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.normal,
                                            color: ColorUtil.signUpColor,
                                            textAlign: TextAlign.center,
                                            basicUiPackage:
                                                UiService.basicUiPackageInit),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        UIText(
                                            "\$${controller.productList[index].userId}",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ColorUtil.priceColor,
                                            textAlign: TextAlign.center,
                                            basicUiPackage:
                                                UiService.basicUiPackageInit),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: UIText(
                                                  "${controller.productList[index].content}",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: ColorUtil.signUpColor,
                                                  textAlign: TextAlign.start,
                                                  textOverFlow:
                                                      TextOverflow.ellipsis,
                                                  maxLine: 1,
                                                  basicUiPackage: UiService
                                                      .basicUiPackageInit),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.addToCart(controller
                                                    .productList[index]);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Icon(
                                                  Icons
                                                      .add_shopping_cart_outlined,
                                                  color: ColorUtil.primaryColor,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
