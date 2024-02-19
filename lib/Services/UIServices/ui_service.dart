import 'package:basic_ui_package/basic_ui_package.dart';
import 'package:flutter/material.dart';

import '../../Utils/colors.dart';

class UiService {
  static BasicUiPackageInit basicUiPackageInit = BasicUiPackageInit();
  UiService(BuildContext buildContext) {
    basicUiPackageInit = BasicUiPackageInit.init(
      buildContext,
      primaryColor: ColorUtil.primaryColor,
      secondaryColor: ColorUtil.signUpColor,
    );
  }

  static void updateChange(BasicUiPackageInit basicUiPackage) {
    basicUiPackageInit = basicUiPackage;
    print("UI SERVICE : Update change : ${basicUiPackageInit.primaryColor}");
  }
}
