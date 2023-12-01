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

import 'package:test_new/mobikul/models/checkout/shipping_info/shipping_address_model.dart';
import 'package:test_new/mobikul/screens/checkout/shipping_info/widget/address_item_card.dart';

import '../../../../app_widgets/app_bar.dart';
import '../../../../helper/app_localizations.dart';
import '../../../../helper/utils.dart';

class ShowAddressList extends StatefulWidget {
  Function(String) onTap;
  ShippingAddressModel? addresses;

   ShowAddressList(this.onTap,this.addresses,{Key? key}) : super(key: key);

  @override
  _ShowAddressListState createState() => _ShowAddressListState();
}

class _ShowAddressListState extends State<ShowAddressList> {
   AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: commonAppBar(
          Utils.getStringValue(context, AppStringConstant.address),
          context,
          isLeadingEnable: true, onPressed: () {
        Navigator.pop(context);
      }),
      body: ListView.builder(
          itemCount: widget.addresses?.address?.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var item = widget.addresses?.address?[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.size8),
              child: InkWell(
                  onTap: () {
                    widget.addresses?.selectedAddressData = item;
                    widget.onTap(item?.id ?? "0");

                    Navigator.pop(context);
                  },
                  child: addressItemCard(item?.value ?? "", context, isSelected: true)),
            );
          },
      ),
    );}
}



