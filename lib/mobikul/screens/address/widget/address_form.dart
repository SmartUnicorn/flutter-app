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

import 'dart:io';
import 'dart:core';
import 'dart:ui';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:location/location.dart';
import 'package:test_new/mobikul/app_widgets/app_text_field.dart';
import 'package:test_new/mobikul/app_widgets/common_outlined_button.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/constants/arguments_map.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/models/address/add_address_request.dart';
import 'package:test_new/mobikul/screens/login_signup/view/signup_extra_views.dart';

import '../../../app_widgets/app_switch_button.dart';
import '../../../configuration/mobikul_theme.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../helper/validator.dart';
import '../../../models/address/address_form_data.dart';
import '../../../models/address/country_datum.dart';
import '../../location_screen/location_screen.dart';
import '../bloc/add_edit_address_screen_bloc.dart';

class AddressForm extends StatefulWidget {
  AddressForm(this.addressFormModel, this.checkout, this.newAddress, this.onSaveAddress,this.isDefault,
      {Key? key})
      : super(key: key);
  final CheckoutAddressFormDataModel? addressFormModel;
  final Function(AddAddressRequest) onSaveAddress;
  bool checkout;
  bool newAddress;
  bool isDefault;

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _firstName,
      _middleName,
      _lastName,
      _prefix,
      _suffix,
      _emailController,
      _company,
      _phoneNumber,
      _fax,
      _address1,
      _address2,
      _address3,
      _city,
      _zip,
      _country,
      _state,
      _defaultBillingAddressController,
      _defaultShippingAddressController;

  String? _selectedCountry,
      _selectedZone,
      _selectedCountryName,
      _selectedZoneName,
      _default;

  List<String> _street = [];

  CountryDataModel? filterCountry;
  StatesDataModel? selectedState;
  List<CountryDataModel>? countryData = [];

  bool changeDefaultBillingAddr = false;
  bool changeDefaultShippingAddr = false;
  bool saveAddressInAddressBook = false;
  bool changeEmail = false;
  String? emailErrorMessage;

  @override
  void initState() {
    _formKey = GlobalKey();
    _firstName = TextEditingController(text: "");
    _middleName = TextEditingController(text: "");
    _lastName = TextEditingController(text: "");
    _prefix = TextEditingController(text: "");
    _suffix = TextEditingController(text: "");
    _fax = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _company = TextEditingController(text: "");
    _phoneNumber = TextEditingController(text: "");
    _address1 = TextEditingController(text: "");
    _address2 = TextEditingController(text: "");
    _address3 = TextEditingController(text: "");
    _city = TextEditingController(text: "");
    _zip = TextEditingController(text: "");
    _country = TextEditingController(text: "");
    _state = TextEditingController(text: "");
    _defaultBillingAddressController = TextEditingController(text: "");
    _defaultShippingAddressController = TextEditingController(text: "");
    _selectedCountryName = "";
    _selectedZoneName = "";
    // For United Kingdom
    _selectedCountry = "222";
    _default = "0";

    _prepareTextFields();
    super.initState();
  }

  void _prepareTextFields() {
    if (widget.newAddress) {
      _firstName.text = widget.addressFormModel?.firstName ?? "";
      _lastName.text = widget.addressFormModel?.lastName ?? "";

      if (widget.addressFormModel?.countryData != null) {
        // var country = widget.addressFormModel?.data?.checkoutAddressFormData?.countryData![0];
        var country = widget.addressFormModel?.getCountryById(_selectedCountry);
        _selectedCountry = country?.country_id;
        countryData = widget.addressFormModel?.countryData;
        _selectedCountryName = country?.name;
        filterCountry = country;
        if (country?.states != null) {
          _selectedZone = country?.states?.elementAt(0).region_id;
          _selectedZoneName = country?.states?.elementAt(0).name;
        }
      }
      // if(widget.isDefault == true){
      //   print("Data===--${widget.isDefault}");
      //   changeDefaultBillingAddr = true;
      //   changeDefaultShippingAddr = true;
      // }

    } else {
      // print("Data==----85${widget.isDefault}");
      var data = widget.addressFormModel;
      if (data?.addressData != null) {
        _prefix.text = data?.addressData?.prifix ?? "";
        _firstName.text = data?.addressData?.firstname ?? "";
        _middleName.text = data?.addressData?.middlename ?? "";
        _lastName.text = data?.addressData?.lastname ?? "";
        _suffix.text = data?.addressData?.suffix ?? "";
        _emailController.text = data?.addressData?.email ?? "";
        _phoneNumber.text = data?.addressData?.telephone ?? "";
        _company.text = data?.addressData?.company ?? "";
        _fax.text = data?.addressData?.fax ?? "";
        _city.text = data?.addressData?.city ?? "";
        _zip.text = data?.addressData?.postcode ?? "";
        _selectedCountry = data?.addressData?.country_id ?? "";
        _selectedZone = data?.addressData?.region_id ?? "";
        widget.addressFormModel?.prefix = data?.addressData?.prifix ?? "";
        widget.addressFormModel?.suffix = data?.addressData?.suffix ?? "";
        if (data?.addressData?.isDefualtShipping is int) {
          changeDefaultShippingAddr = (data?.addressData?.isDefualtShipping == 1) ? true : false;
        } else {
          changeDefaultShippingAddr = data?.addressData?.isDefualtShipping??false;
        }

        if (data?.addressData?.isDefaultBilling is int) {
          changeDefaultBillingAddr = (data?.addressData?.isDefaultBilling == 1) ? true : false;
        } else {
          changeDefaultBillingAddr = data?.addressData?.isDefaultBilling??false;
        }
        saveAddressInAddressBook =
        (data?.addressData?.saveAddress == 1) ? true : false;
        countryData = widget.addressFormModel?.countryData;
      }

      if (data?.addressData?.street != null &&
          (data?.addressData?.street?.length)! >= 1) {
        _address1.text = data?.addressData?.street?[0] ?? "";
        print("TEST LOG STREET INDEX 0 ${data?.addressData?.street?[0] ?? ""}");
      }
      if (data?.addressData?.street != null &&
          (data?.addressData?.street?.length ?? 0) > 1) {
        _address2.text = data?.addressData?.street?[1] ?? "";
        print("TEST LOG STREET INDEX 1 ${data?.addressData?.street?[1] ?? ""}");
      }
      if (data?.addressData?.street != null &&
          (data?.addressData?.street?.length ?? 0) > 2) {
        _address3.text = data?.addressData?.street?[2] ?? "";
        print("TEST LOG STREET INDEX 2 ${data?.addressData?.street?[2] ?? ""}");
      }
      var country = widget.addressFormModel?.getCountryById(_selectedCountry);
      _selectedCountryName = country?.name;
      filterCountry = country;
      countryData = widget.addressFormModel?.countryData;
      _selectedCountry = filterCountry?.country_id;

      print("TEST_DATA====> ${country?.getStatesById(_selectedZone)?.name}");
      _selectedZoneName = country?.getStatesById(_selectedZone)?.name;

      _state.text = _selectedZoneName ?? (data?.addressData?.region??"");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.spacingNormal),
      child: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      // headingText(_localizations?.translate(

                      //     AppStringConstant.contactInformation) ??
                      //     ""),
                      SizedBox(height: AppSizes.size34),
                    ],
                  ),

                  /// Contact Information Heading
                  Text(
                    Utils.getStringValue(
                        context, AppStringConstant.contactInformation),
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.ltr,
                  ),

                  /// prefix selection
                  if ((widget.addressFormModel?.isPrefixVisible ?? false) &&
                      (widget.addressFormModel?.prefixHasOptions ?? false))
                    Column(
                      children: [
                        const SizedBox(
                          height: AppSizes.size16,
                        ),
                        DropdownButtonFormField<String>(
                          elevation: 0,
                          menuMaxHeight: AppSizes.deviceHeight / 2,
                          hint: Text(
                            widget.addressFormModel?.addressData?.prifix ??
                                Utils.getStringValue(
                                    context, AppStringConstant.namePrefix),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          decoration: formFieldDecoration(
                              context,
                              "",
                              Utils.getStringValue(
                                  context, AppStringConstant.namePrefix),
                              isDense: true,
                              isRequired: true),
                          items: (widget.addressFormModel?.prefixOptions ?? [])
                              .map((String optionData) {
                            return DropdownMenuItem(
                              value: optionData,
                              child: Text(
                                optionData ?? "",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            // this will call once the value changes
                            widget.addressFormModel?.prefix = value.toString();
                            setState(() {});
                          },
                          validator: (value) {
                            if (widget.addressFormModel?.prefix?.isEmpty ??
                                true) {
                              if ((widget.addressFormModel?.isPrefixVisible ??
                                  false) &&
                                  (widget.addressFormModel?.prefixHasOptions ??
                                      false) &&
                                  (widget.addressFormModel?.isPrefixRequired ??
                                      false))
                                return Utils.getStringValue(
                                    context, AppStringConstant.required);
                              // add validation with return statement
                            }
                          },
                        ),
                      ],
                    ),

                  /// prefix custom
                  if ((widget.addressFormModel?.isPrefixVisible ?? false) &&
                      !(widget.addressFormModel?.prefixHasOptions ?? false))
                    Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        AppTextField(
                          controller: _prefix,
                          isRequired:
                          widget.addressFormModel?.isPrefixRequired ??
                              false,
                          isPassword: false,
                          hintText: Utils.getStringValue(
                              context, AppStringConstant.namePrefix),
                          inputType: TextInputType.name,
                        ),
                      ],
                    ),

                  /// FirstName custom
                  const SizedBox(height: AppSizes.size16),
                  AppTextField(
                    controller: _firstName,
                    isRequired: true,
                    isPassword: false,
                    hintText: Utils.getStringValue(
                        context, AppStringConstant.firstName),
                    inputType: TextInputType.name,
                  ),

                  ///Middle name
                  if (widget.addressFormModel?.isMiddlenameVisible ?? false)
                    Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        AppTextField(
                          controller: _middleName,
                          isRequired: false,
                          isPassword: false,
                          hintText: Utils.getStringValue(
                              context, AppStringConstant.middleName),
                          inputType: TextInputType.name,
                        ),
                      ],
                    ),

                  /// LasttName custom
                  const SizedBox(height: AppSizes.size16),
                  AppTextField(
                    controller: _lastName,
                    isRequired: true,
                    isPassword: false,
                    hintText: Utils.getStringValue(
                        context, AppStringConstant.lastName),
                    inputType: TextInputType.name,
                  ),

                  /// suffix selection
                  if ((widget.addressFormModel?.isSuffixVisible ?? false) &&
                      (widget.addressFormModel?.suffixHasOptions ?? false))
                    Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        DropdownButtonFormField<String>(
                          elevation: 0,
                          menuMaxHeight: AppSizes.deviceHeight / 2,
                          hint: Text(
                            widget.addressFormModel?.addressData?.suffix ??
                                Utils.getStringValue(
                                    context, AppStringConstant.nameSuffix),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          decoration: formFieldDecoration(
                              context,
                              "",
                              Utils.getStringValue(
                                  context, AppStringConstant.nameSuffix),
                              isDense: true,
                              isRequired: true),
                          items: (widget.addressFormModel?.suffixOptions ?? [])
                              .map((String optionData) {
                            return DropdownMenuItem(
                              value: optionData,
                              child: Text(
                                optionData ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            // this will call once the value changes
                            widget.addressFormModel?.suffix =
                                value.toString() ?? "";
                            setState(() {});
                          },
                          validator: (value) {
                            if (widget.addressFormModel?.prefix?.isEmpty ??
                                true) {
                              if ((widget.addressFormModel?.isSuffixVisible ??
                                  false) &&
                                  (widget.addressFormModel?.suffixHasOptions ??
                                      false) &&
                                  (widget.addressFormModel?.isSuffixRequired ??
                                      false))
                                return Utils.getStringValue(
                                    context, AppStringConstant.required);
                              // add validation with return statement
                            }
                          },
                        ),
                      ],
                    ),

                  /// suffix custom
                  if ((widget.addressFormModel?.isSuffixVisible ?? false) &&
                      !(widget.addressFormModel?.suffixHasOptions ?? false))
                    Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        AppTextField(
                          controller: _suffix,
                          isRequired:
                          widget.addressFormModel?.isSuffixRequired ??
                              false,
                          isPassword: false,
                          hintText: Utils.getStringValue(
                              context, AppStringConstant.nameSuffix),
                          inputType: TextInputType.name,
                        ),
                      ],
                    ),

                  /// Email address
                  if (!appStoragePref.isLoggedIn())
                    Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        TextFormField(
                          controller: _emailController,
                          style: Theme.of(context).textTheme.bodyText2,
                          decoration: formFieldDecoration(
                              context,
                              "",
                              Utils.getStringValue(
                                  context, AppStringConstant.emailAddress),
                              isRequired: true),
                          autovalidateMode: (_emailController.text.isNotEmpty)
                              ? AutovalidateMode.always
                              : AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return Validator.isEmailValid(value ?? '', context);
                          },
                          onChanged: (value) async {
                            // if (Validator.isEmailValid(value, context) ==
                            //     null) {
                            //   _emailController.text =
                            //       (_emailController.text ?? "").trim();
                            //   // bloc?.add(CheckEmailEvent(value, await appStoragePref.getCustomerToken()));
                            // } else {
                            //   emailErrorMessage = null;
                            // }
                          },
                        ),
                        if (emailErrorMessage != null)
                          Padding(
                            padding: const EdgeInsets.all(AppSizes.size4),
                            child: Text(
                              emailErrorMessage!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.red),
                            ),
                          ),
                      ],
                    ),

                  /// PhoneNumber custom
                  if (widget.addressFormModel?.isMobileVisible ?? true)
                    Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        AppTextField(
                          controller: _phoneNumber,
                          isRequired: true,
                          // widget.addressFormModel?.isMobileRequired??false,
                          isPassword: false,
                          hintText: Utils.getStringValue(
                              context, AppStringConstant.phoneNumber),
                          inputType: TextInputType.phone,
                        ),
                      ],
                    ),

                  /// company
                  if (widget.addressFormModel?.isCompanyVisible ?? false)
                    Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        AppTextField(
                          controller: _company,
                          isRequired:
                          widget.addressFormModel?.isCompanyRequired ??
                              false,
                          isPassword: false,
                          hintText: Utils.getStringValue(
                              context, AppStringConstant.company),
                          inputType: TextInputType.name,
                        ),
                      ],
                    ),

                  /// fax
                  if (widget.addressFormModel?.isFaxVisible ?? false)
                    Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        AppTextField(
                          controller: _company,
                          isRequired:
                          widget.addressFormModel?.isFaxRequired ?? false,
                          isPassword: false,
                          hintText: Utils.getStringValue(
                              context, AppStringConstant.company),
                          inputType: TextInputType.name,
                        ),
                      ],
                    ),

                  /// Address Heading
                  const SizedBox(height: AppSizes.size16),
                  Text(
                    Utils.getStringValue(context, AppStringConstant.address),
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.start,
                  ),

                  /// Name Address1 custom
                  const SizedBox(height: AppSizes.size16),
                  AppTextField(
                    controller: _address1,
                    isRequired: false,
                    isPassword: false,
                    hintText: Utils.getStringValue(
                        context, AppStringConstant.address1),
                    inputType: TextInputType.name,
                  ),

                  /// Name Address2 custom
                  if (((widget.addressFormModel?.streetLineCount ?? 0) > 1))
                    Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        AppTextField(
                          controller: _address2,
                          isRequired: false,
                          isPassword: false,
                          hintText: Utils.getStringValue(
                              context, AppStringConstant.address2),
                          inputType: TextInputType.name,
                        ),
                      ],
                    ),

                  /// Name Address3 custom

                  if (((widget.addressFormModel?.streetLineCount ?? 0) > 2))
                    Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        AppTextField(
                          controller: _address3,
                          isRequired: false,
                          isPassword: false,
                          hintText: Utils.getStringValue(
                              context, AppStringConstant.address3),
                          inputType: TextInputType.name,
                        ),
                      ],
                    ),

                  /// Name City custom
                  const SizedBox(height: AppSizes.size16),
                  AppTextField(
                    controller: _city,
                    isRequired: true,
                    isPassword: false,
                    hintText:
                    Utils.getStringValue(context, AppStringConstant.city),
                    inputType: TextInputType.name,
                  ),

                  /// Zip
                  const SizedBox(height: AppSizes.size16),
                  AppTextField(
                    controller: _zip,
                    isRequired: true,
                    isPassword: false,
                    hintText: Utils.getStringValue(
                        context, AppStringConstant.zipPostalCode),
                    inputType: TextInputType.number,
                  ),

                  /// Country and state

                  countryAndStateSpinner(
                      widget.addressFormModel?.countryData, filterCountry),

                  /// Switch Default Billing Address
                  if (!widget.checkout && appStoragePref.isLoggedIn())
                    if(widget.isDefault != true)
                      Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        AppSwitchButton(
                            Utils.getStringValue(context,
                                AppStringConstant.changeDefaultBillingAddress),
                                (value) {
                              setState(() {
                                changeDefaultBillingAddr = value;
                                _defaultBillingAddressController.clear();
                                _defaultBillingAddressController.clear();
                                _defaultBillingAddressController.clear();
                              });
                            }, changeDefaultBillingAddr),
                      ],
                    ),

                  /// Switch Default Shipping Address
                  if (!widget.checkout && appStoragePref.isLoggedIn())
                    if(widget.isDefault != true)
                      Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        AppSwitchButton(
                            Utils.getStringValue(context,
                                AppStringConstant.changeDefaultShippingAddress),
                                (value) {
                              setState(() {
                                changeDefaultShippingAddr = value;
                                _defaultShippingAddressController.clear();
                                _defaultShippingAddressController.clear();
                                _defaultShippingAddressController.clear();
                              });
                            }, changeDefaultShippingAddr),
                      ],
                    ),

                  /// Switch save Address
                  if (widget.checkout && appStoragePref.isLoggedIn())
                    Column(
                      children: [
                        const SizedBox(height: AppSizes.size16),
                        AppSwitchButton(
                            Utils.getStringValue(context,
                                AppStringConstant.saveInAddressBook),
                                (value) {
                              setState(() {
                                saveAddressInAddressBook = value;
                              });
                            }, saveAddressInAddressBook),

                      ],
                    ),



                  const SizedBox(height: AppSizes.size16),
                  ElevatedButton(
                    onPressed: () async {
                      Utils.hideSoftKeyBoard();
                      var validate = _formKey.currentState?.validate();
                      var defaultShipping = 0;
                      var defaultBilling = 0;
                      var saveAddress = 0;
                      if(widget.isDefault == true){
                        changeDefaultShippingAddr = true;
                        changeDefaultBillingAddr = true;
                        // defaultBilling = 1;
                        // defaultShipping = 1;
                      }

                      if (changeDefaultShippingAddr) {
                        defaultShipping = 1;
                      } else {
                        defaultShipping = 0;
                      }

                      if (changeDefaultBillingAddr) {
                        defaultBilling = 1;
                      } else {
                        defaultBilling = 0;
                      }

                      if (saveAddressInAddressBook) {
                        saveAddress = 1;
                      } else {
                        saveAddress = 0;
                      }

                      _street = [];
                      _street.add(_address1.text ?? "");
                      if (((widget.addressFormModel?.streetLineCount ?? 0) >
                          1)) {
                        _street.add(_address2.text ?? "");
                      }
                      if (((widget.addressFormModel?.streetLineCount ?? 0) >
                          2)) {
                        _street.add(_address3.text ?? "");
                      }

                      if (validate == true) {
                        widget.onSaveAddress(AddAddressRequest(
                            prefix:
                            (widget.addressFormModel?.prefixHasOptions ??
                                false)
                                ? widget.addressFormModel?.prefix ?? ""
                                : _prefix.text,
                            firstName: _firstName.text,
                            middleName: _middleName.text,
                            lastName: _lastName.text,
                            suffix:
                            (widget.addressFormModel?.suffixHasOptions ??
                                false)
                                ? widget.addressFormModel?.suffix ?? ""
                                : _suffix.text,
                            email: (appStoragePref.isLoggedIn())
                                ? appStoragePref.getUserData()?.email ?? ""
                                : Utils.replaceWhitespacesUsingRegex(
                                _emailController.text, ''),
                            telephone: _phoneNumber.text,
                            company: _company.text,
                            fax: _fax.text,
                            street: _street,
                            city: _city.text,
                            postcode: _zip.text,
                            region_id: _selectedZone,
                            regionName: selectedState == null
                                ? _state.text
                                : _selectedZoneName,
                            country_id: _selectedCountry,
                            countryName: _selectedCountryName,
                            default_billing: defaultBilling,
                            default_shipping: defaultShipping,
                            save_address: saveAddress
                        ));
                      }
                    },
                    child: Center(
                        child: Text(
                          Utils.getStringValue(
                              context,
                              Utils.getStringValue(
                                  context, AppStringConstant.saveAddress))
                              .toUpperCase(),
                          style: const TextStyle(color: AppColors.white),
                        )),
                  ),
                ],
              ),
            ),
            // if (Platform.isAndroid)
              Positioned(
                right: 0,
                child: InkWell(
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LocationScreen()))
                        .then((value) {
                      print('TEST_LOG--Address----- $value');
                      if (value is Map) {
                        _address1.text = value['street1'] ??  value['street2'] ??  value['street3'] ??"";
                        if (((widget.addressFormModel?.streetLineCount ?? 0) >
                            1)) {
                          _address2.text =  "";
                              // value['street2'] ?? value['street3'] ?? "";
                        }
                        _city.text = value['city'];
                        _zip.text = value['zip'];
                        _city.text = value['city'];

                        if (filterCountry != null &&
                            (filterCountry?.states?.length ?? 0) > 0) {
                          _state.text = value['state'];
                        }

                        if (widget.addressFormModel?.countryData != null) {
                          setState(() {
                            var country = widget.addressFormModel
                                ?.getCountryById(value['isoCountryCode']);
                            if ((country?.country_id??"").toString() == (value['isoCountryCode']??"").toString()) {
                              filterCountry = country;
                              _selectedCountry = value['isoCountryCode'];
                              _selectedCountryName = value['country'];
                              if (country?.states != null) {
                                country?.states?.forEach((element) {
                                  if (Platform.isAndroid) {
                                    if ((element.name ?? "").trim().toLowerCase() ==
                                        (value['state'] ?? "")
                                            .toString()
                                            .trim()
                                            .toLowerCase()) {
                                      _selectedZone = element.region_id;
                                      _selectedZoneName = element.name;
                                    }
                                  } else {
                                    if ((element.code ?? "").trim().toLowerCase() ==
                                        (value['state'] ?? "")
                                            .toString()
                                            .trim()
                                            .toLowerCase()) {
                                      _selectedZone = element.region_id;
                                      _selectedZoneName = element.name;
                                    }
                                  }

                                });
                              }
                            }
                          });
                        }
                      }
                    });
/*                  var status =
              await locationReq.Location.instance.hasPermission();
              if (status == locationReq.PermissionStatus.granted ||
                  status == locationReq.PermissionStatus.grantedLimited) {
                Navigator.pushNamed(context, AppRoute.location)
                    .then((value) {
                  if (value is Map) {
                    print('values ----- $value');
                    filterSelectedCountryAndState(
                      value["country"],
                      value["state"],
                    );
                    _city.text = value['city'];
                    _zip.text = value['zip'];
                    _address1.text = "${value['street1']}";
                    _address2.text = "${value['street2']}";
                  }
                });
              } else {
                DialogHelper.locationPermissionDialog(
                    AppStringConstant.requiredLocationPermission, context,
                    onConfirm: () async {
                      var status = await locationReq.Location.instance
                          .requestPermission();
                      if (status ==
                          locationReq.PermissionStatus.deniedForever) {
                        DialogHelper.locationPermissionDialog(
                            AppStringConstant.provideLocationPermission,
                            context, onConfirm: () async {
                          openAppSettings();
                        });
                      }
                    });
              }*/
                  },
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                            color: Colors.grey.shade800,
                          )
                        ]),
                    child: Icon(
                      Icons.my_location,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget countryAndStateSpinner(
      List<CountryDataModel?>? countryData, CountryDataModel? selected) {
    CountryDataModel? selectedCountry;
    bool showState = false;
    if (selected != null) {
      selectedCountry = selected;
      if (selected.states?.isEmpty == false) {
        showState = true;
      } else {
        showState = false;
      }
    }
    return StatefulBuilder(
      builder: (context, setState) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              const SizedBox(height: AppSizes.size16),
              CommonDropDownField(
                value: widget.checkout == false
                    ? _selectedCountryName
                    : countryData
                    ?.firstWhereOrNull((e) =>
                e?.country_id == selectedCountry?.country_id)
                    ?.name ??
                    countryData?.first?.name,
                hintText:
                Utils.getStringValue(context, AppStringConstant.country),
                itemList: getCountryStrings(),
                key: const Key('country'),
                callBack: dropdownUpdate,
              ),
              const SizedBox(height: AppSizes.size16),
              (filterCountry != null &&
                  (filterCountry?.states?.length ?? 0) > 0)
                  ? CommonDropDownField(
                value: selectedState != null
                    ? selectedState?.name
                    : _selectedZoneName,
                itemList: selectedCountry?.states
                    ?.map((e) => e.name ?? '')
                    .toList() ??
                    [],
                hintText: Utils.getStringValue(
                    context, AppStringConstant.state),
                key: const Key('States'),
                callBack: dropdownUpdate,
                // dropdownUpdate,
              )
                  : AppTextField(
                controller: _state,
                isRequired: true,
                isPassword: false,
                hintText: Utils.getStringValue(
                    context, AppStringConstant.state),
                inputType: TextInputType.text,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<String> getCountryStrings() {
    List<String> country = [];
    if (countryData != null) {
      for (CountryDataModel item in countryData ?? []) {
        if (item.name != null) {
          country.add(item.name ?? "");
        } else {
          country.add("Select Country...");
        }
      }
    }
    return country;
  }

  void dropdownUpdate(String item, Key? key) {
    if (key == const Key('country')) {
      var country = countryData?.firstWhereOrNull((e) => e.name == item);
      filterCountry = country;
      if ((country?.states?.length ?? 0) > 0) {
        selectedState = country?.states?.first;
        _selectedZoneName = selectedState?.name ?? "";
        _selectedZone = selectedState?.region_id ?? "";
      }
      _selectedCountryName = filterCountry?.name ?? "";
      _selectedCountry = filterCountry?.country_id;
    } else if (key == const Key('States')) {
      if (filterCountry != null) {
        var state = filterCountry?.states
            ?.firstWhereOrNull((element) => element.name == item);
        if (state != null) {
          selectedState = state;
        }
      }
      _selectedZoneName = selectedState?.name ?? "";
      _selectedZone = selectedState?.region_id ?? "";
    }
    setState(() {});
  }

  Widget fieldItem(
      TextEditingController controller, String label, bool isRequired) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            if (isRequired)
              const Text(
                "*",
                style: TextStyle(color: Colors.red),
              )
          ],
        ),
        const SizedBox(height: AppSizes.size8),
        AppTextField(
          controller: controller,
          isPassword: false,
          helperText: label,
          isRequired: isRequired,
        ),
      ],
    );
  }
}

class CommonDecoration {
  InputDecoration formFieldDecoration(
      BuildContext context,
      String? helperText,
      String? hintText, {
        bool? isDense = true,
        bool? isRequired,
        Widget? suffix,
      }) {
    return InputDecoration(
      isDense: isDense,
      helperText: helperText,
      labelText: (hintText ?? "") +
          ((isRequired ?? false) && (hintText != '') ? "*" : ""),
      hintStyle: const TextStyle(
          fontFeatures: [FontFeature.enable("sups")], color: Colors.white),
      // fillColor: MobikulTheme.accentColor,
      suffixIcon: suffix,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.size10),
          borderSide: BorderSide(
            color: Colors.grey,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.size10),
          borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.size10),
          borderSide: BorderSide(
            color: Colors.grey,
          )),
    );
  }
}
