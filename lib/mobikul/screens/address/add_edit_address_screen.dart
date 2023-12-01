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
import 'package:test_new/mobikul/app_widgets/app_bar.dart';
import 'package:test_new/mobikul/app_widgets/loader.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/constants/global_data.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/models/address/address_form_data.dart';
import 'package:test_new/mobikul/screens/address/bloc/add_edit_address_screen_events.dart';
import 'package:test_new/mobikul/screens/address/bloc/add_edit_address_screen_states.dart';
import 'package:test_new/mobikul/screens/address/widget/address_form.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../constants/app_routes.dart';
import '../../helper/app_storage_pref.dart';
import 'bloc/add_edit_address_screen_bloc.dart';

class AddEditAddressScreen extends StatefulWidget {
  AddEditAddressScreen(
      this.addressId, this.newAddressDataModel, this.isCheckout,this.isDefault,
      {Key? key})
      : super(key: key);
  final String? addressId;
  AddressDataModel? newAddressDataModel;
  bool? isCheckout;
  bool? isDefault;

  @override
  State<StatefulWidget> createState() => _AddEditAddressScreen();
}

class _AddEditAddressScreen extends State<AddEditAddressScreen> {
  AddEditAddressScreenBloc? _addEditAddressScreenBloc;
  CheckoutAddressFormDataModel? _addressFormData;
  late bool isLoading;

  @override
  void initState() {
    isLoading = true;
    _addEditAddressScreenBloc = context.read<AddEditAddressScreenBloc>();
    _addEditAddressScreenBloc
        ?.add(AddEditAddressScreenDataFetchEvent(widget.addressId ?? ""));
    print("====----===-->${widget.isDefault}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: commonAppBar(
            (widget.addressId?.isEmpty ?? true)
                ? (widget.newAddressDataModel?.firstname?.isEmpty ?? true)
                ? Utils.getStringValue(
                context, AppStringConstant.addNewAddress)
                : Utils.getStringValue(
                context, AppStringConstant.editAddress)
                : Utils.getStringValue(context, AppStringConstant.editAddress),
            context,
            isLeadingEnable: false, onPressed: () {
          Navigator.pop(context);
        }),
        body: _buildMainUi());
  }

  Widget _buildMainUi() {
    return BlocBuilder<AddEditAddressScreenBloc, AddEditAddressState>(
      builder: (context, currentState) {
        if (currentState is AddEditAddressInitial) {
          isLoading = true;
        } else if (currentState is AddressDetailFetchSuccess) {
          isLoading = false;
          _addressFormData = currentState.model;
          print("===--==>${_addressFormData}");
          if (_addressFormData != null) {
            GlobalData.getCheckoutAddressFormDataModel = _addressFormData;
          }
          if (widget.addressId?.isEmpty ?? false) {
            _addressFormData?.addressData = widget.newAddressDataModel;
          }
          // print("TEST_LOG===>test====> ${_addressFormData?.success}");
        } else if (currentState is AddAddressSuccess) {
          isLoading = false;
          if (currentState.model.success == true) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.model.message ?? '', context);
              Navigator.pop(context, true);
            });
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.model.message ?? '', context);
            });
          }
        } else if (currentState is AddEditAddressError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message ?? '', context);
          });
        }
        return (_addressFormData != null) ? _buildUI(context) : Loader();
      },
    );
  }

  Widget _buildUI(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: _addressFormData != null,
          child: AddressForm(_addressFormData, widget.isCheckout ?? false,
              (widget.addressId?.isEmpty ?? true)
                  ? (widget.newAddressDataModel?.firstname?.isEmpty ?? true)
                  ? true
                  : false
                  : false,
                  (request) {
                print("teasdytfasdf===> ${widget.isCheckout}");
                if ((widget.isCheckout ?? false)) {
                  appStoragePref.setUserAddressData(AddressDataModel(
                    isDefaultBilling: request.default_billing,
                    isDefualtShipping: request.default_shipping,
                    entity_id: "",
                    prifix: request.prefix,
                    firstname: request.firstName,
                    middlename: request.middleName,
                    lastname: request.lastName,
                    suffix: request.suffix,
                    email: request.email,
                    telephone: request.telephone,
                    company: request.company,
                    fax: request.fax,
                    street: request.street,
                    city: request.city,
                    postcode: request.postcode,
                    region_id: request.region_id,
                    region: request.regionName,
                    country_id: request.country_id,
                    countryName: request.countryName,
                    saveAddress: request.save_address,
                  ));
                  Navigator.of(context).pop(request);
                } else {
                  _addEditAddressScreenBloc
                      ?.add(AddAddressEvent(widget.addressId ?? "", request));
                }
              },widget.isDefault ?? false ),
        ),
        Visibility(
          child: const Loader(),
          visible: isLoading,
        ),
      ],
    );
  }
}
