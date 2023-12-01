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

import 'package:flutter/material.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/utils.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/arguments_map.dart';
import '../../../../models/categoryPage/category.dart';


Widget categoryList(BuildContext context, List<Category> ?data, Function callback,  ){
  return Container(
    color: Theme.of(context).cardColor,
    height: 100,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.size16),
          child: Text(Utils.getStringValue(context, AppStringConstant.categories).toUpperCase() ?? '' ,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),

        Expanded(
          child: ListView.builder(
            // shrinkWrap: true,
              itemCount: data?.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    callback();
                    Navigator.pushNamed(context, AppRoutes.subCategory,
                        arguments: categoryMap(
                            data?[index].id??0, data?[index].name??"", ""));

                  },
                  child: Container(
                    margin: const EdgeInsets.only(right:AppSizes.size8,left: AppSizes.size4, bottom: AppSizes.size16),
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.size4, horizontal: AppSizes.size16),
                   decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular( 20.0)),
                     color: AppColors.black,
                    ),
                    child: Center(child: Text(data?[index].name??'', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: AppColors.white),)),



                  ),
                );
              }),
        ),
      ],
    ),
  );
}


Widget commonContainer(BuildContext context, Widget child, {Color? color, Color? shadowColor, double? borderRadius , double? verticalPadding,double? horizontalPadding, double? verticalMargin,double? horizontalMargin, double? height, double? width,double? shadowBlurRadius }){
  return Container(
    padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0, horizontal: horizontalPadding ?? verticalPadding ?? 0),
    margin: EdgeInsets.symmetric(vertical: verticalMargin ?? 0 , horizontal: horizontalMargin ?? verticalMargin ?? 0 ),
    height: height ,
    width: width ,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8.0)),
        color: color,
        boxShadow:   [
          BoxShadow(
            color: shadowColor ?? Theme.of(context).cardColor,
            blurRadius: shadowBlurRadius ?? 0,
          )]
    ),
    child: child,
  );
}
