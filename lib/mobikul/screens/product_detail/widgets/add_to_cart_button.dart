/*
 *
 *  Webkul Software.
 * @package Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/utils.dart';

import '../../../app_widgets/app_outlined_button.dart';
import '../../../constants/app_constants.dart';
import '../../../helper/app_localizations.dart';
import '../../../models/productDetail/product_detail_page_model.dart';
import '../bloc/product_detail_screen_bloc.dart';
import '../bloc/product_detail_screen_events.dart';
import '../bloc/product_detail_screen_state.dart';

class AddToCartButtonView extends StatelessWidget {
  AppLocalizations? _localizations;
  ProductDetailScreenBloc? productPageBloc;
  ProductDetailPageModel? _productDetailPageModel;
  int counter;
  List downloadLinks = [];
  List<dynamic> groupedParams = [];
  List<dynamic> bundleParams = [];
  List<dynamic> customOptionSelection = [];
  List<dynamic> relatedProducts = [];
  final ValueChanged<bool>? callback;

  Map<String, dynamic> mProductParamsJSON = new Map();

  AddToCartButtonView(
      this.productPageBloc,
      this._productDetailPageModel,
      this.counter,
      this.downloadLinks,
      this.groupedParams,
      this.bundleParams,
      this.customOptionSelection,
      {Key? key,
      this.callback});

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context);
    return Container(
        // height: AppSizes.deviceHeight / 13,
        child: Container(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: AppSizes.genericButtonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    if (collectAllOptionData(true, context)) {
                      print(
                          "TEST_LOG ===> mProductParamsJSON ==> ${mProductParamsJSON}");
                      productPageBloc?.add(AddtoCartEvent(
                          false,
                          _productDetailPageModel?.id?.toString() ?? "",
                          counter,
                          mProductParamsJSON,
                          relatedProducts));
                    }
                  },

                  child: Center(
                      child: Text(
                    Utils.getStringValue(context, AppStringConstant.addToCart)
                            .toUpperCase() ??
                        '',
                    style: const TextStyle(color: Colors.white),
                  )),
                  // style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: AppSizes.genericButtonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (collectAllOptionData(true, context)) {
                        print(
                            "TEST_LOG ===> mProductParamsJSON ==> ${mProductParamsJSON}");
                        productPageBloc?.add(AddtoCartEvent(
                            true,
                            _productDetailPageModel?.id?.toString() ?? "",
                            counter,
                            mProductParamsJSON,
                            relatedProducts));
                      }
                    },
                    child: Center(
                        child: Text(
                      Utils.getStringValue(context, AppStringConstant.buyNow)
                              .toUpperCase() ??
                          '',
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                ))
          ],
        ),
      ),
    ));
  }

  bool collectAllOptionData(bool isChecksEnabled, BuildContext context) {
    bool isAllRequiredOptionFilled = true;

    try {
      print("TEST_LOG ===> Available ${_productDetailPageModel?.isAvailable}");

      if (_productDetailPageModel?.isAvailable ?? true) {
        switch (_productDetailPageModel?.typeId) {
          case "configurable":
            {
              List<dynamic> configurableOptnList = [];
              _productDetailPageModel?.configurableData?.attributes
                  ?.forEach((attributeElement) {
                Map<String, String> configurableOptnObj = new Map();
                if (attributeElement.swatchType == "visual" ||
                    attributeElement.swatchType == "text") {
                  var selectedItemId = "";
                  attributeElement.options?.forEach((element) {
                    if (element.swatchData?.isSelected ?? false) {
                      selectedItemId = element.swatchData?.id.toString() ?? "";
                    }
                  });

                  if (isChecksEnabled && selectedItemId.isEmpty) {
                    productPageBloc?.emit(ProductDetailScreenErrorAlert(
                        Utils.getStringValue(context,
                            AppStringConstant.selectConfigurableOptionsMsg)));
                    isAllRequiredOptionFilled = false;
                  } else {
                    // configurableOptnObj[attributeElement.id?.toString()??""] = selectedItemId;
                    // configurableOptnObj[attributeElement.id?.toString()??""] = selectedItemId;
                    configurableOptnObj["id"] =
                        attributeElement.id?.toString() ?? "";
                    configurableOptnObj["value"] = selectedItemId;
                  }
                  configurableOptnList.add(configurableOptnObj);
                } else {
                  var selectedItemId = "";
                  attributeElement.options?.forEach((element) {
                    if (element.swatchData?.isSelected ?? false) {
                      selectedItemId = element.swatchData?.id.toString() ?? "";
                    }
                  });

                  print("TEST_LOG ===> selectedItemId ${selectedItemId}");

                  if (isChecksEnabled && selectedItemId.isEmpty) {
                    productPageBloc?.emit(ProductDetailScreenErrorAlert(
                        Utils.getStringValue(context,
                            AppStringConstant.selectConfigurableOptionsMsg)));
                    isAllRequiredOptionFilled = false;
                  } else {
                    // configurableOptnObj[attributeElement.id?.toString()??""] = selectedItemId;
                    configurableOptnObj["id"] =
                        attributeElement.id?.toString() ?? "";
                    configurableOptnObj["value"] = selectedItemId;
                  }
                  configurableOptnList.add(configurableOptnObj);
                }
              });
              mProductParamsJSON["superAttribute"] = configurableOptnList;
              break;
            }
          case "downloadable":
            {
              if (downloadLinks.isNotEmpty) {
                mProductParamsJSON["links"] = downloadLinks;
              } else {
                isAllRequiredOptionFilled = false;
                productPageBloc?.emit(ProductDetailScreenErrorAlert(
                    Utils.getStringValue(context,
                        AppStringConstant.selectConfigurableOptionsMsg)));
              }
              break;
            }
          case "grouped":
            {
              if (groupedParams.isNotEmpty) {
                mProductParamsJSON["superGroup"] = groupedParams;
                debugPrint(
                    "TEST_LOG ==> grouped ==>   ${mProductParamsJSON.toString()}");
              } else {
                productPageBloc?.emit(ProductDetailScreenErrorAlert(
                    Utils.getStringValue(context,
                        AppStringConstant.selectConfigurableOptionsMsg)));
              }
              break;
            }
          case "bundle":
            {
              // _productDetailPageModel?.bundleOptions?.optionValues?.forEach((element) {
              //   if (bundleParams.isNotEmpty) {
              //     // list.add(bundleParams);
              //     debugPrint("TEST_LOG ==> bundleParams ==>   ${bundleParams.toString()}");
              //   } else {
              //     productPageBloc?.emit(ProductDetailScreenErrorAlert(AppStringConstant.selectConfigurableOptionsMsg));
              //     return;
              //   }
              // });

              mProductParamsJSON["bundleOption"] = bundleParams;
              break;
            }
        }

        if (isAllRequiredOptionFilled &&
            (_productDetailPageModel?.customOptions ?? []).isNotEmpty) {
          _productDetailPageModel?.customOptions?.forEach((attributeElement) {
            mProductParamsJSON["options"] = customOptionSelection;
            switch (attributeElement.type) {
              case "drop_down":
                //Spinner View;

                // mProductParamsJSON["options"] = customOptionSelection;
                break;
              case "radio":
                //RadioView

                break;
              case "checkbox":
                //CheckBoxView

                break;
              case "multiple":
                //CheckBoxView

                break;
              case "field":
                //EditTextView

                break;
              case "area":
                //EditTextView

                break;

              default:
                break;
            }
          });
        }

        ///get related product data

        relatedProducts = [];
        _productDetailPageModel?.relatedProductList?.forEach((element) {
          if (element.isChecked ?? false) {
            relatedProducts.add(element.entityId);
          }
        });
      }
    } catch (e) {
      isAllRequiredOptionFilled = false;
      print(e);
    }

    return isAllRequiredOptionFilled;
  }
}

class ProductParams {
  String? id;
  dynamic? value;

  ProductParams({this.id, this.value});
  factory ProductParams.fromJson(Map<String, dynamic> json) => ProductParams(
        id: json["id"] ?? null,
        value: json["value"] == null ? null : json["value"],
      );
  Map<String, dynamic> toJson() => {
        id.toString(): value,
      };
}
