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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import 'package:test_new/mobikul/screens/order_details/views/order_heading_view.dart';
import 'package:test_new/mobikul/screens/order_details/views/order_id_date_view.dart';
import 'package:test_new/mobikul/screens/order_details/views/order_invoice_shipment_view.dart';
import 'package:test_new/mobikul/screens/order_details/views/order_item_card.dart';
import 'package:test_new/mobikul/screens/order_details/views/order_price_details.dart';
import 'package:test_new/mobikul/screens/order_details/views/order_shipping_payment_info.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/dialog_helper.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/arguments_map.dart';
import '../../helper/app_localizations.dart';
import '../../helper/utils.dart';
import '../../models/order_details/order_detail_model.dart';
import '../orders_list/bloc/order_screen_bloc.dart';
import '../orders_list/bloc/order_screen_state.dart';
import 'bloc/order_detail_screen_bloc.dart';

class OrderDetails extends StatefulWidget {
  String orderId;
  OrderDetails(this.orderId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OrderDetailState();
  }
}

class _OrderDetailState extends State<OrderDetails> {
  bool isLoading = false;
  bool isVisibleOrderOptions = false;
  OrderDetailModel? _orderModel;
  OrderDetailsBloc? _orderBloc;

  @override
  void initState() {
    super.initState();

    _orderBloc = context.read<OrderDetailsBloc>();
    _orderBloc?.add(OrderDetailFetchEvent(widget.orderId));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          Utils.getStringValue(context, AppStringConstant.itemOrdered), context,
          actions: [
            // PopupMenuButton(itemBuilder: (context){
            //   return [
            //   // PopupMenuItem<int>(
            //
            //   )
            //       ];
            // })
          ]),
      body: BlocBuilder<OrderDetailsBloc, OrderDetailState>(
        builder: (context, state) {
          if (state is OrderDetailInitial) {
            isLoading = true;
            isVisibleOrderOptions = false;
          } else if (state is OrderDetailSuccess) {
            isLoading = false;
            _orderModel = state.model;
            if (_orderModel?.state == "complete" ||
                _orderModel?.state == "processing" ||
                _orderModel?.state == "closed") {
              isVisibleOrderOptions = true;
            } else {
              isVisibleOrderOptions = false;
            }
          } else if (state is AddProductToCartStateSuccess) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(state.baseModel.message ?? '', context);
              Navigator.pushNamed(context, AppRoutes.cart);
            });
            _orderBloc?.emit(OrderDetailEmptyState());
          } else if (state is ReorderSuccessState) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              DialogHelper.confirmationDialog(
                  Utils.getStringValue(
                      context, AppStringConstant.reorderDescription),
                  context,
                  AppLocalizations.of(context),
                  title:
                      Utils.getStringValue(context, AppStringConstant.reorder),
                  onConfirm: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.cart,
                );
              },
                  okButton: Utils.getStringValue(
                      context, AppStringConstant.gotoCart));
            });
            _orderBloc?.emit(OrderDetailEmptyState());
          } else if (state is OrderDetailError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(state.message ?? '', context);
            });
            _orderBloc?.emit(OrderDetailEmptyState());
          }
          return buildUI();
        },
      ),
    );
  }

  Widget buildUI() {
    return Stack(
      children: [
        Visibility(
            visible: _orderModel != null,
            child: (_orderModel?.success ?? false)
                ? Container(
                    width: AppSizes.deviceWidth,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(AppSizes.paddingMedium),
                            topRight: Radius.circular(AppSizes.paddingMedium)),
                        border: Border.all(color: Theme.of(context).cardColor)),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                              visible: isVisibleOrderOptions,
                              child: ExpansionTile(
                                iconColor: Theme.of(context).iconTheme.color,
                                collapsedIconColor:
                                    Theme.of(context).iconTheme.color,
                                title: Text(
                                    Utils.getStringValue(context,
                                        AppStringConstant.itemsOrdered),
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                children: [
                                  ListTile(
                                    title: orderInvoiceShipmentViewContainer(
                                        context,
                                        _orderModel,
                                        AppLocalizations.of(context)),
                                  )
                                ],
                              )),
                          orderIdContainer(context, _orderModel,
                              AppLocalizations.of(context)),
                          orderPlaceDateContainer(context, _orderModel,
                              AppLocalizations.of(context)),
                          const Divider(
                            thickness: 1,
                            height: 1,
                          ),
                          orderedItemList(),

                          // const SizedBox(
                          //   height: AppSizes.paddingNormal,
                          // ),
                          //  deliveryBoyInfo(context, AppLocalizations.of(context), _orderModel),
                          // const SizedBox(
                          //   height: AppSizes.paddingNormal,
                          // ),
                          orderPriceDetails(_orderModel ?? OrderDetailModel(),
                              context, AppLocalizations.of(context)),
                          // const SizedBox(
                          //   height: AppSizes.paddingNormal,
                          // ),
                          const Divider(
                            thickness: 1,
                            height: 1,
                          ),
                          if (_orderModel?.shippingAddress?.isNotEmpty ==
                                  true ||
                              _orderModel?.billingAddress?.isNotEmpty == true)
                            shippingPaymentInfo(context,
                                AppLocalizations.of(context), _orderModel),

                          // const SizedBox(
                          //   height: AppSizes.paddingNormal,
                          // ),
                          if (_orderModel?.canReorder == true &&
                              appStoragePref.isLoggedIn())
                            reorderView(context)
                        ],
                      ),
                    ),
                  )
                : Container()),
        Visibility(
          visible: isLoading,
          child: const Loader(),
        ),
      ],
    );
  }

  Widget orderedItemList() {
    return orderHeaderLayout(
        context,
        '${_orderModel?.orderData?.itemList?.length} ${Utils.getStringValue(context, AppStringConstant.itemsOrdered)}',
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.spacingGeneric),
          child: ListView.builder(
              itemCount: _orderModel?.orderData?.itemList?.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.productPage,
                        arguments: getProductDataAttributeMap(
                          _orderModel?.orderData?.itemList?[index].name ?? "",
                          _orderModel?.orderData?.itemList?[index].productId ??
                              "",
                        ));
                  },
                  child: Column(
                    children: [
                      orderItemCard(
                          _orderModel?.orderData?.itemList?[index] ??
                              OrderItem(),
                          context,
                          AppLocalizations.of(context)),
                      const Divider(
                        thickness: 1,
                        height: 1,
                      ),
                    ],
                  ),
                );
              }),
        ));
  }

  Widget reorderView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.size8),
      child: SizedBox(
        width: AppSizes.deviceWidth,
        height: AppSizes.genericButtonHeight,
        child: ElevatedButton(
          onPressed: () {
            _orderBloc?.add(ReorderEvent(_orderModel?.incrementId ?? ""));
          },
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              const Icon(
                Icons.repeat,
                size: AppSizes.size16,
                color: AppColors.white,
              ),
              const SizedBox(
                width: AppSizes.size4,
              ),
              Text(
                AppStringConstant.reorder.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: AppColors.white,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
