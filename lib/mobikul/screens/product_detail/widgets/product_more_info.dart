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
import 'package:flutter_html/flutter_html.dart';

import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/models/productDetail/additional_information.dart';


productInfo(List<AdditionalInformation>? additionalInfo, BuildContext context, ){
 return Container(
   color: Theme.of(context).cardColor,
   margin: const EdgeInsets.only(top: AppSizes.size8),
   child: ExpansionTile(
       initiallyExpanded:  true ,
       title: Text(
           Utils.getStringValue(context, AppStringConstant.moreInformation) ?? '',
           style: Theme.of(context).textTheme.subtitle2),
       children: [
         ListView.separated(
           shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
           itemCount: additionalInfo?.length ?? 0,
           itemBuilder: (context, index){
               return IntrinsicHeight(
                 child: Row(
                   children: [
                     SizedBox(
                       width: (AppSizes.deviceWidth/ 3) - AppSizes.size16,
                       child: Text(additionalInfo?[index].label ?? '', textAlign: TextAlign.right,),
                     ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: AppSizes.size8),
                      //   width: 2, color: Colors.blue,),
                      VerticalDivider(
                       thickness: 0.5,
                       color: Theme.of(context).dividerColor,
                       width: AppSizes.size16,
                     ),
                     SizedBox(
                       width: ((AppSizes.deviceWidth *2)/3) - AppSizes.size16,
                       child: Text(additionalInfo?[index].value ?? '', textAlign: TextAlign.left,),
                     )
                     // SizedBox(
                     //     width: ((AppSizes.deviceWidth *2)/3) - AppSizes.size16,
                     //     child: Html(data: additionalInfo?[index].value ?? '')),
                   ],
                 ),
               );
           },
           separatorBuilder: (context, index){
             return const Divider( height: 2,);
           },
         )
       ]),
 );
}
