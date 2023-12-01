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
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/mobikul/app_widgets/app_alert_message.dart';
import 'package:test_new/mobikul/app_widgets/app_bar.dart';
import 'package:test_new/mobikul/app_widgets/app_order_button.dart';
import 'package:test_new/mobikul/app_widgets/app_switch_button.dart';
import 'package:test_new/mobikul/app_widgets/dialog_helper.dart';
import 'package:test_new/mobikul/app_widgets/loader.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/models/cart/price_details.dart';
import 'package:test_new/mobikul/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/mobikul/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/mobikul/models/checkout/place_order/place_order_model.dart';
import 'package:test_new/mobikul/screens/cart/widgets/discount_view.dart';
import 'package:test_new/mobikul/screens/cart/widgets/price_detail_view.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/Payment_info_bloc.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/Payment_info_bloc.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/payment_info_events.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/payment_info_state.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/widgets/order_summary.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/widgets/payment_methods.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/widgets/payment_web_view.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/widgets/place_order_screen.dart';
import 'package:test_new/mobikul/screens/checkout/shipping_info/widget/address_item_card.dart';
import 'package:test_new/mobikul/screens/checkout/shipping_info/widget/checkout_progress_line.dart';

import '../../../configuration/mobikul_theme.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/checkout/place_order/billing_data_request.dart';
import '../../../models/checkout/shipping_info/shipping_address_model.dart';

class PaymentInfoScreen extends StatefulWidget {
  final Map<String, dynamic> args;
  PaymentInfoScreen(this.args, {Key? key}) : super(key: key);

  @override
  State<PaymentInfoScreen> createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  AppLocalizations? _localizations;
  bool isAddressSame = true;
  bool isLoading = true;
  PaymentInfoModel? paymentInfoModel;
  PaymentInfoScreenBloc? paymentInfoScreenBloc;
  PlaceOrderModel? placeOrderModel;
  String selectedPaymentMethodCode = '';
  BillingDataRequest? billingDataRequest;
  ShippingAddressModel? _addressListModel;

  @override
  void initState() {
    paymentInfoScreenBloc = context.read<PaymentInfoScreenBloc>();
    paymentInfoScreenBloc
        ?.add(GetPaymentInfoEvent(widget.args[shippingMethodKey]));
    _addressListModel = widget.args[addressKey];
    if (widget.args[isVirtualKey] ?? false) {
      isAddressSame = false;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
            _localizations?.translate(AppStringConstant.reviewPayments) ?? "",
            context),
        body: BlocBuilder<PaymentInfoScreenBloc, PaymentInfoScreenState>(
            builder: (context, currentState) {
          if (currentState is PaymentInfoScreenInitial) {
            isLoading = true;
          } else if (currentState is GetPaymentMethodSuccess) {
            isLoading = false;
            paymentInfoModel = currentState.paymentModel;
            if (_addressListModel == null) {
              paymentInfoScreenBloc?.add(const CheckoutAddressFetchEvent());
            }
          } else if (currentState is CheckoutAddressSuccess) {
            isLoading = false;
            if (currentState.model.success ?? false) {
              _addressListModel = currentState.model;
              if (_addressListModel?.address != null) {
                _addressListModel?.selectedAddressData =
                    _addressListModel?.address?[0];
              }
            }

            if (appStoragePref.getUserAddressData()?.firstname?.isNotEmpty ??
                false) {
              Address addressData = Address(
                  value: _addressListModel?.getFormattedAddress(
                      appStoragePref.getUserAddressData()!),
                  id: "",
                  isNew: true);
              List<Address>? address = [];
              address.add(addressData);
              if (_addressListModel?.address != null) {
                _addressListModel?.address?.add(addressData);
              } else {
                _addressListModel?.address = address;
              }
              _addressListModel?.selectedAddressData = addressData;

              _addressListModel?.hasNewAddress = true;
            }
          } else if (currentState is PlaceOrderSuccess) {
            isLoading = false;
            appStoragePref.setQuoteId(0);
            appStoragePref.setCartCount(0);
            placeOrderModel = currentState.placeOrderModel;
            if (selectedPaymentMethodCode == "quickpay_gateway") {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                paymentInfoScreenBloc?.add(GetQuickPayRedirectLinkEvent(
                    (placeOrderModel?.incrementId ?? '').toString()));
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PlaceOrderScreen(placeOrderModel)));
              });
            }
            paymentInfoScreenBloc?.emit(PaymentInfoScreenEmptyState());
          } else if (currentState is ApplyCouponState) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.data.message != ''
                      ? currentState.data.message ?? ''
                      : Utils.getStringValue(
                          context, AppStringConstant.deleteItemFromCart),
                  context);
            });
            paymentInfoScreenBloc
                ?.add(GetPaymentInfoEvent(widget.args[shippingMethodKey]));
          } else if (currentState is PaymentInfoScreenError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.message ??
                      Utils.getStringValue(
                          context, AppStringConstant.somethingWentWrong),
                  context);
            });
            paymentInfoScreenBloc?.emit(PaymentInfoScreenEmptyState());
          } else if (currentState is GetQuickPayRedirectLinkSuccess) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentWebView(
                            currentState?.data?.url ?? '',
                            (result, message, {String? successUrl}) {
                              if (result) {
                                WidgetsBinding.instance
                                    ?.addPostFrameCallback((_) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlaceOrderScreen(
                                                  placeOrderModel)));
                                });
                              } else {
                                DialogHelper.confirmationDialog(
                                  Utils.getStringValue(
                                      context, AppStringConstant.cancelPayment),
                                  context,
                                  _localizations,
                                  onConfirm: () {
                                    SchedulerBinding.instance
                                        ?.addPostFrameCallback((_) {
                                      dispose();
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.cart,
                                          (Route<dynamic> route) => false);
                                    });
                                  },
                                );
                              }
                              print(message);
                            },
                            success: ['success'],
                            failure: ["cart", "failure"],
                            cancel: ["cart", "failure"],
                          )));
            });
            paymentInfoScreenBloc?.emit(PaymentInfoScreenEmptyState());
          } else if (currentState is ChangeBillingAddressState) {
            paymentInfoScreenBloc
                ?.add(GetPaymentInfoEvent(widget.args[shippingMethodKey]));
          }
          return _buildUI();
        }));
  }

  Widget _buildUI() {
    return Stack(
      children: [
        Visibility(
            visible: paymentInfoModel != null,
            child: paymentInfoModel?.success ?? false
                ? Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              checkoutProgressLine(false, context),
                              showBillingAddress(
                                  context, AppStringConstant.billingAddress),
                              DiscountView(
                                discountApplied:
                                    paymentInfoModel?.couponCode?.isNotEmpty ??
                                        false,
                                discountCode:
                                    paymentInfoModel?.couponCode ?? "",
                                onClickApply: (discountCode) {
                                  paymentInfoScreenBloc?.add(ApplyCouponEvent(
                                      discountCode.toString() ?? "", 0));
                                },
                                onClickRemove: (discountCode) {
                                  paymentInfoScreenBloc?.add(ApplyCouponEvent(
                                      paymentInfoModel?.couponCode.toString() ??
                                          "",
                                      1));
                                },
                              ),
                              if (widget.args[shippingMethodKey] != "")
                                shippinginfo(AppStringConstant.shippingInfo),
                              paymentMethod(),
                              orderSummary(
                                  context,
                                  _localizations,
                                  paymentInfoModel?.orderReviewData?.items ??
                                      []),
                              PriceDetailView(
                                  paymentInfoModel?.orderReviewData?.totals ??
                                      [],
                                  _localizations)
                            ],
                          ),
                        ),
                      ),
                      commonOrderButton(context, _localizations,
                          paymentInfoModel?.total ?? "", () async {
                        billingDataRequest = BillingDataRequest(
                            sameAsShipping: isAddressSame ? 1 : 0,
                            addressId:
                                _addressListModel?.selectedAddressData?.id);

                        if ((!isAddressSame &&
                            (appStoragePref.getUserAddressData()?.firstname ??
                                    "")
                                .isEmpty)) {
                          AlertMessage.showError(
                              _localizations?.translate(AppStringConstant
                                      .paymentAddressSelectError) ??
                                  "",
                              context);
                        } else if (selectedPaymentMethodCode.isEmpty) {
                          AlertMessage.showError(
                              _localizations?.translate(
                                      AppStringConstant.selectPaymentMethod) ??
                                  "",
                              context);
                        } else {
                          paymentInfoScreenBloc?.add(PlaceOrderEvent(
                            selectedPaymentMethodCode,
                            widget.args[shippingMethodKey],
                            billingDataRequest!,
                          ));
                          paymentInfoScreenBloc
                              ?.emit(PaymentInfoScreenInitial());
                          var mHiveBox =
                              await HiveStore.openBox("graphqlClientStore");
                          mHiveBox.clear();
                        }
                      }, title: AppStringConstant.placeOrder)
                    ],
                  )
                : Container()),
        Visibility(
          visible: isLoading,
          child: const Loader(),
        ),
      ],
    );
  }

  Widget showBillingAddress(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.size8),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.size8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.size8, horizontal: AppSizes.size8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_localizations?.translate(title) ?? '',
                      style: Theme.of(context).textTheme.headline3),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            if (widget.args[shippingMethodKey] != "")
              AppSwitchButton(
                _localizations
                        ?.translate(AppStringConstant.sameAsShippingAddress) ??
                    '',
                billingAddress,
                isAddressSame,
                isFromPaymentInfo: true,
              ),
            Visibility(
              visible: !isAddressSame || (widget.args[shippingMethodKey] == ""),
              child: addressItemCard(
                  _addressListModel?.selectedAddressData?.value ?? "", context,
                  isElevated: false,
                  actions: actionContainer(context, () {
                    shippingAddressModelBottomSheet(context, (value) {
                      paymentInfoScreenBloc?.add(const ChangeAddressEvent());
                    }, _addressListModel);
                  }, () {
                    Navigator.of(context).pushNamed(AppRoutes.addEditAddress,
                        arguments: {
                          addressId: "",
                          address: appStoragePref.getUserAddressData(),
                          isCheckout: true
                        }).then((value) {
                      print("TEST_LOG ==> address ==> ${value}");
                      paymentInfoScreenBloc?.emit(PaymentInfoScreenInitial());
                      paymentInfoScreenBloc
                          ?.add(const CheckoutAddressFetchEvent());
                    });
                  },
                      titleLeft: _localizations
                              ?.translate(AppStringConstant.changeAddress) ??
                          '',
                      titleRight: (_addressListModel?.hasNewAddress ?? false)
                          ? _localizations
                                  ?.translate(AppStringConstant.editAddress) ??
                              ''
                          : _localizations
                                  ?.translate(AppStringConstant.newAddress) ??
                              '',
                      iconLeft: Icons.edit,
                      iconRight: (_addressListModel?.hasNewAddress ?? false)
                          ? Icons.edit
                          : Icons.add,
                      isNewAddress: ((_addressListModel?.hasNewAddress ?? false)
                          ? (_addressListModel?.selectedAddressData?.isNew ??
                              false)
                          : true),
                      hasAddress:
                          ((_addressListModel?.selectedAddressData?.value ?? "")
                                  .isNotEmpty
                              ? true
                              : false))),
            )
          ],
        ),
      ),
    );
  }

  Widget shippinginfo(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.size12),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.size8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.size8),
              child: Text(_localizations?.translate(title) ?? "",
                  style: Theme.of(context).textTheme.headline3),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: AppSizes.size8,
                  left: AppSizes.size8,
                  right: AppSizes.size8),
              child: Text(
                  _localizations
                          ?.translate(AppStringConstant.shippingAddress)
                          .toUpperCase() ??
                      "",
                  style: Theme.of(context).textTheme.headline3),
            ),
            addressItemCard(paymentInfoModel?.shippingAddress ?? '', context,
                isElevated: false),
            Padding(
              padding: const EdgeInsets.only(
                  top: AppSizes.size8,
                  left: AppSizes.size8,
                  right: AppSizes.size8),
              child: Text(
                  _localizations
                          ?.translate(AppStringConstant.shippingMethod)
                          .toUpperCase() ??
                      "",
                  style: Theme.of(context).textTheme.headline3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.linePadding, horizontal: AppSizes.size8),
              child: Text(
                paymentInfoModel?.shippingMethod ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.size12),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.size8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.size8),
              child: Text(
                  _localizations?.translate(AppStringConstant.paymentMethods) ??
                      "",
                  style: Theme.of(context).textTheme.headline3),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            PaymentMethodsView(
              paymentMethods: getActivePaymentMethod(
                  paymentInfoModel?.paymentMethods ?? []),
              callBack: (index) {
                selectedPaymentMethodCode = index;
              },
              paymentCallback: () {},
            )
          ],
        ),
      ),
    );
  }

  void billingAddress(bool isOn) {
    setState(() {
      isAddressSame = isOn;
      // isAddressSame = !isAddressSame;
    });
  }

  List<PaymentMethods> getActivePaymentMethod(
      List<PaymentMethods> allPaymentMethods) {
    List<PaymentMethods> activePaymentMEthods = [];

    allPaymentMethods.forEach((element) {
      if (AppConstant.allowedPaymentMethods.contains(element.code)) {
        activePaymentMEthods.add(element);
      }
    });

    return activePaymentMEthods;
  }
}
