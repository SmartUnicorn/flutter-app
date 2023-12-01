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
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/mobikul/models/checkout/shipping_info/shipping_methods_model.dart';

class PaymentMethodsView extends StatefulWidget {
  ValueChanged<String>? callBack;
  List<PaymentMethods>? paymentMethods;
  VoidCallback? paymentCallback;

  PaymentMethodsView(
      {Key? key,
        this.callBack,
        this.paymentMethods,
        this.paymentCallback})
      : super(key: key);

  @override
  _ShippingMethodsState createState() => _ShippingMethodsState();
}

class _ShippingMethodsState extends State<PaymentMethodsView> {
  String selectedPaymentCode = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
             widget.paymentMethods?.length ?? 0,
            (index) {
              PaymentMethods? item;
          if ((widget.paymentMethods ?? []).isNotEmpty) {
            item = widget.paymentMethods?[index];
          } else {
            item = widget.paymentMethods?[index];
          }
          return Padding(
            padding: const EdgeInsets.only(top: AppSizes.size8, left: AppSizes.size16, ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile<String>(
                      activeColor: Theme.of(context).iconTheme.color,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      selected: selectedPaymentCode == item?.code,
                      subtitle: Text("${item?.extraInformation} " ,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.normal),
                      ),
                      title: Text("${item?.title} " ,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      value: (item?.code ?? "").toString(),
                      groupValue:
                      (selectedPaymentCode == item?.code) ? (item?.code) : "",
                      onChanged: (value) {
                        setState(() {
                          if (widget.paymentCallback != null) {
                            widget.paymentCallback!();
                          }
                          selectedPaymentCode = item?.code ?? '';
                          if (widget.callBack != null) {
                            widget.callBack!(selectedPaymentCode);
                          }
                        });
                      },
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.5,
                  height: 0.5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}